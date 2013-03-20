class Route < ActiveRecord::Base
  belongs_to :trip
  has_many :places, dependent: :destroy
  has_many :way_places, dependent: :destroy
  attr_accessible :distance, :end_location, :notes, :start_location, :trip_id
  validates :distance, numericality: true
  validates :start_location, :end_location, presence: true
end
