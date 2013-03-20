class WayPlace < ActiveRecord::Base
  attr_accessible :name, :place_id, :route_id
  validates :name, :place_id, :route_id, presence: true
  validates :place_id, uniqueness: true
end
