class Route < ActiveRecord::Base
  attr_accessible :distance, :notes, :trip_id, :seq_no, :start_place, :end_place, :start_route, :start_place_id, :end_place_id, :active, :drive_time
  belongs_to :trip
  validates :distance, numericality: true, :allow_nil => true


  # normally.. this would not be unassigned.. but the model allows it
  def start_place_name
    if start_place_id
      begin
        Place.find(start_place_id).name
      rescue ActiveRecord::RecordNotFound
        return "Unassigned"
      end

    else
       "Unassigned"
     end
  end

  # normally.. this would not be unassigned.. but the model allows it
  def end_place_name
    if end_place_id 
      begin
        Place.find(end_place_id).name
      rescue ActiveRecord::RecordNotFound
        "Unassigned"
      end
    else
       "Unassigned"
     end
  end

  def start_place
    begin
      Place.find(start_place_id) if start_place_id
    rescue ActiveRecord::RecordNotFound
      Place.new
    end
  end

  def end_place
    begin
      Place.find(end_place_id) if end_place_id 
    rescue ActiveRecord::RecordNotFound
      Place.new
    end
  end


  def cost_of_gas
    distance ? distance / 30 : 0
  end

  # count those at the start of the trip, and during the trip (but not end -- that goes with another route)
  def cost_of_activities
    cost = 0
    places = [start_place].concat(start_place.my_minor_places)
    places.each do |place|
      Activity.where(place_id: place.id).each do |act|
        cost += act.cost
      end
    end
    return cost
  end

  def self.remove_inactive
    Route.where(active: false).each do |route|
      route.destroy
    end
  end

  # routes must adapt to places; when places get added or moved around routes are updated.
  def self.fix_routes(trip_id)
    trip = Trip.find(trip_id)
    places = trip.major_places.order("seq_no ASC")
    first_place = places.shift
    good_routes={}
    wanted_route_seq=1
  # make sure active routes map to places in the current order
    places.each do |next_place|
      if rt=Route.where(start_place_id: first_place.id, end_place_id: next_place.id).first
        rt.update_attributes(active: true) if !rt.active 
        rt.update_attributes(seq_no: wanted_route_seq) if rt.seq_no != wanted_route_seq
      else
        logger.debug "Creating new route from #{first_place.id} to #{next_place.id}"
        Route.create(trip_id: trip.id, start_place_id: first_place.id, end_place_id: next_place.id, seq_no: wanted_route_seq)
      end
      good_routes["#{first_place.id}-#{next_place.id}"] = true     # save good routes so we can inactivate the rest below 
      first_place = next_place
      wanted_route_seq +=1
    end
  # inactivate all routes that are no longer connected by places.
    routes = trip.routes.order('seq_no ASC')
    if routes
      first_route = routes.first
      last_route = routes.last
      routes.each do |route|
        if !good_routes["#{route.start_place_id}-#{route.end_place_id}"]
          route.update_attributes(active: false)
        end
      end
    end
  end
end
