class Activity < ActiveRecord::Base
  has_one :activity_types
  validates :activity_type, :name, presence: true
  validates :cost, numericality: true
  attr_accessible :activity_type, :cost, :name, :notes
end
