class ActivityType < ActiveRecord::Base
  belongs_to :activity
  validates :activity_type, presence: true, uniqueness: true
  attr_accessible :description, :activity_type
end
