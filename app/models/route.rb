class Route < ActiveRecord::Base
  belongs_to :trip
  has_many :way_places, dependent: :destroy
  has_many :places, through: :way_places
  attr_accessible :distance, :notes, :trip_id, :seq_no, :start_place, :end_place

  validates :distance, numericality: true, :allow_nil => true
  before_save :init_seq_no

  def init_seq_no
    if seq_no.nil?
      self[:seq_no] = Route.count + 1
    end
  end


  # will not be set for new routes
  def start_place
    if id
      Route.get_route_places(id, "start_place")
    else
      nil
    end
  end

  def end_place
    if id
      Route.get_route_places(id, "end_place")
    else
      nil
    end
  end

  def start_place=(place_id)
    WayPlace.create(route_id: self.id, place_id: place_id, place_kind: "start_place")
  end

  def end_place=(place_id)
    WayPlace.create(route_id: self.id, place_id: place_id, place_kind: "end_place")
  end

  def mid_places
    Route.get_route_places(id, "way_place")
  end


  # normally.. this would not be unassigned.. but the model allows it
  def start_place_name
    s = start_place

    if s
      s.name
    else 
       "Unassigned"
     end
  end

  # normally.. this would not be unassigned.. but the model allows it
  def end_place_name
    e = end_place
    if e
      e.name
    else 
       "Unassigned"
     end
  end


  def cost_of_gas
    distance ? distance / 30 : 0
  end

  # count those at the start of the trip, and during the trip (but not end -- that goes with another route)
  def cost_of_activities
    cost = 0
    self.way_places.each do |wp|
      if wp.place_kind == "start_place" or wp.place_kind == "way_place"
        Activity.where(place_id: wp.place_id).each do |act|
          cost += act.cost
        end
      end
    end
    return cost
  end

# class methods

  def self.trip_routes(trip_id)
    if trip_id.nil?
      return []
    else
      return Trip.find(trip_id).routes.map {|rt| [ Route.get_route_name(rt.id), rt.id]}
    end
  end

  def self.get_route_name(route_id)
    start_place_name = end_place_name = "Unassigned"
    Route.find(route_id).way_places.each do |wp|
      if wp.place_kind == "start_place"
        start_place_name=Place.find(wp.place_id).name
      elsif wp.place_kind == "end_place"
        end_place_name = Place.find(wp.place_id).name
      end
    end
    return "#{start_place_name} to #{end_place_name}"
  end

 
  # a little kludgy - it may return one record or an array depending on the kind
  def self.get_route_places(route_id, want_place_kind)
    places = []
    route = Route.find(route_id)
    route.way_places.each do |wp|
      if (want_place_kind == "start_place"  && wp.place_kind == "start_place")
        return Place.find(wp.place_id)
      elsif (want_place_kind == "end_place"  && wp.place_kind == "end_place")
        return Place.find(wp.place_id)
      elsif (want_place_kind == "way_place" && wp.place_kind == "way_place")
        places << Place.find(wp.place_id)
      end
    end
    if want_place_kind == "way_place"
      return places
    else
      return nil
    end    
  end
end
