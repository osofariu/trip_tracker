class WayPlace < ActiveRecord::Base
  attr_accessible :name, :place_id, :route_id
  validates :name, :place_id, :route_id, presence: true
end
