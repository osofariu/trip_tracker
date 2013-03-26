class WayPlace < ActiveRecord::Base
  attr_accessible  :place_id, :route_id
  validates :place_id, :route_id, presence: true
  validates :place_id, uniqueness: true
end
