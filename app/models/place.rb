class Place < ActiveRecord::Base
  attr_accessible :name, :notes, :place_type
  has_many :activities, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true

public
  def self.get_by_id (id)
    place = Place.find(id)
  end

  def get_activities
    Activity.where(place_id: id)
  end
end
