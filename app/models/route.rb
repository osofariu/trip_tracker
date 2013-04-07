class Route < ActiveRecord::Base
  attr_accessible :distance, :notes, :trip_id, :seq_no, :start_place, :end_place, :start_route
  belongs_to :trip
  has_many :way_places, dependent: :destroy
  has_many :places, through: :way_places
  validates :distance, numericality: true, :allow_nil => true
  before_save :init_seq_no
  after_save  :save_wayplaces

  def save_wayplaces
    if @s_place
      if wp=way_places.find_by_place_kind("start_place")
        logger.debug "Updating start_place using wp #{wp.id}"
        wp.place_id = @s_place.id
        wp.save
      else
        logger.debug "Creating new wayplace for start"
        way_places << WayPlace.new(place_id: @s_place.id, place_kind: "start_place", route_id: self.id)
      end
    end
    if @e_place
      if wp=way_places.find_by_place_kind("end_place")
        logger.debug "Updating start_place using wp #{wp.id}"
        wp.place_id = @e_place.id
        wp.save
      else
        logger.debug "Creating new wayplace for end"
        way_places << WayPlace.new(place_id: @e_place.id, place_kind: "end_place", route_id: self.id)
      end
    end
  end

  def init_seq_no
    if seq_no.nil?
      self[:seq_no] = Route.count + 1
    end
  end

  def start_place
    wp = way_places.find_by_place_kind("start_place")
    if wp
      return Place.find(wp.place_id)
    else
      return nil
    end
  end

  def start_place_id
    if start_place
      start_place.id
    else
      nil
    end
  end

    def end_place_id
    if end_place
      end_place.id
    else
      nil
    end
  end

  def end_place
    wp = way_places.find_by_place_kind("end_place")
    if wp
      return Place.find(wp.place_id)
    else
      return nil
    end
  end

  def start_place=(place)
    if place.class == String
      @s_place = Place.find(place)
    else
      @s_place = place
    end
    logger.debug "===> saving start #{@s_place.id}"
  end

  def end_place=(place)
    if place.class == String
      @e_place = Place.find(place)
    else
      @e_place = place
    end
  end  


  def mid_places
    places = []
    way_places.where(route_id: id, place_kind: "way_place").each do |wp|
      logger.debug "#{wp.id}, #{wp.place_kind}, #{wp.place_id}"
      places << wp.place
    end
    return places
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
end
