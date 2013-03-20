class Place < ActiveRecord::Base
  attr_accessible :name, :notes, :route_id
  validates :name, :route_id, presence: true
end
