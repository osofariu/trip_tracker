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
end
