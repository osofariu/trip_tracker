class Route < ActiveRecord::Base
  belongs_to :trip
  has_many :way_places, dependent: :destroy
  attr_accessible :distance, :end_place, :notes, :start_place, :trip_id
  validates :distance, numericality: true, :allow_nil => true
  validates :start_place, :end_place, presence: true
  validate :unique_segment, on: :create

  def unique_segment
    if Route.where(start_place: start_place, end_place: end_place).any?
      errors.add(:start_place, "must have unique route between two places")
    end
  end

  def route_name
    from=Place.find(start_place).name
    to=Place.find(end_place).name
    return "#{from} to #{to}"
  end

public

  def get_places
    places = {}
    places[:start] = Place.find(start_place)
    places[:end] = Place.find(end_place)
    places[:way_places] = []
    WayPlace.where(route_id: id).each do |wp|
      places[:way_places] << Place.where(id: wp.place_id).first
    end
    return places
  end

  def cost_of_gas
    if distance
      distance / 30
    else
      0
    end
  end

  def cost_of_activities
    cost = 0
    Activity.where(place_id: self.start_place).each do |act|
      cost += act.cost
    end
    WayPlace.where(route_id: self.id).each do |wp|
      cost += wp.cost_of_activities
    end
    return cost
  end

  def show_route_info
    start_place = Place.find(self.start_place)
    end_place = Place.find(self.end_place)
    route_lines = []
    route_lines << "Traveling: #{distance} miles to #{end_place.name} for the gas cost of: $#{cost_of_gas} and activities cost of: $#{cost_of_activities}."
    route_lines << "Notes: #{notes}" if (notes)
    return route_lines
  end
end
