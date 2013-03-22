class Activity < ActiveRecord::Base
  has_one :activity_types
  validates :activity_type, :name, presence: true
  validates :cost, numericality: true
  validates :name, uniqueness: true
  attr_accessible :activity_type, :cost, :name, :notes, :place_id

public
  def self.get_by_id (id)
    Activity.find(id)
  end

  def get_type_name
    ActivityType.find(activity_type).activity_type
  end
end
