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
end
