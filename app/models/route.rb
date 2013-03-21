class Route < ActiveRecord::Base
  belongs_to :trip
  has_many :places, dependent: :destroy
  has_many :way_places, dependent: :destroy
  attr_accessible :distance, :end_location, :notes, :start_location, :trip_id
  validates :distance, numericality: true, :allow_nil => true
  validates :start_location, :end_location, presence: true
  validate :unique_segment, on: :create

  def unique_segment
    if Route.where(start_location: start_location, end_location: end_location).any?
      errors.add(:start_location, "must have unique route between two places")
    end
  end
end
