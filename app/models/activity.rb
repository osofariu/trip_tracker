class Activity < ActiveRecord::Base
  has_one :activity_types
  validates :activity_type, :name, presence: true
  validates :cost, numericality: true, :allow_nil => true
  validates :name, uniqueness: true
  attr_accessible :activity_type, :cost, :name, :notes, :place_id
  before_save :set_cost

public

  def set_cost
    if cost.nil?
      self[:cost] = 0
    end
  end
  def self.get_by_id (id)
    Activity.find(id)
  end

  def get_type_name
    ActivityType.find(activity_type).activity_type
  end

  def show_activity_info
    cost_str = cost > 0 ? "for #{cost}" : ""
    "#{name} (#{ActivityType.find(activity_type).activity_type}) #{cost_str}"
  end

  def self.trip_activities(trip_id)
    activities = []
    Place.where(trip_id: trip_id).each do |place|
      Activity.where(place_id: place.id).each do |activity|
        activities << activity
      end
    end
    return activities
  end
end
