class WayPlace < ActiveRecord::Base
  attr_accessible  :place_id, :route_id, :place_kind
  belongs_to :route
  belongs_to :place

  validates :place_id, :route_id, :place_kind, presence: true
  validates :place_kind, inclusion: {in: ["way_place", "start_place", "end_place"],
    message: "%{value} is not a valid kind of place"}
  validate :unique_route_place_kind, on: :create


  def unique_route_place_kind
    # unique start places and end places
    if place_kind == "start_place" && WayPlace.where(place_id: place_id, route_id: route_id).any?
      errors.add(:place_kind, "You cannot start more than one routes from the same place.")
    end
    if place_kind == "end_place" && WayPlace.where(place_id: place_id, route_id: route_id).any?
      errors.add(:place_kind, "You cannot end more than one route at the same place.")
    end    
  end


  def cost_of_activities
    cost = 0
    Activity.where(place_id: self.place_id).each do |act|
      cost += act.cost
    end
    return cost
  end

# class methods

  def self.trip_way_places(trip_id)
    wps = []
    Route.where(trip_id: trip_id).each do |route|
      wps.concat route.way_places
    end
    return wps
  end
end
