class Place < ActiveRecord::Base
  attr_accessible :name, :notes, :place_type, :trip_id
  has_many :activities, dependent: :destroy
  validates :name, :trip_id, presence: true
  validates :name, uniqueness: true


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

  def self.user_unassigned_places(trip_id)
    places = []
    Trip.where(user_id: user_id).each do |t|
      Route.where(trip_id: t.id).each do |rt|
        places.concat rt.places.all
      end
    end
    return places
  end
end