class Place < ActiveRecord::Base
  attr_accessible :name, :notes, :place_type, :trip_id, :seq_no, :base_id
  has_many :way_places
  has_many :routes, through: :way_places
  has_many :activities, dependent: :destroy
  has_many :child_places, class_name: "Place", foreign_key: "base_id"

  validates :name, :trip_id, presence: true
  validates :name, uniqueness: true
  before_save :init_seq_no

  def init_seq_no
    if seq_no.nil? or seq_no == 0
      self[:seq_no] = Place.count + 1
    end
  end


  def self.get_by_id (id)
    place = Place.find(id)
  end

  def get_activities
    Activity.where(place_id: id)
  end


  def self.user_places(user_id)
    places = []
    Trip.where(user_id: user_id).each do |t|
      Route.where(trip_id: t.id).each do |rt|
        places.concat rt.places.all
      end
    end
    return places
  end
end