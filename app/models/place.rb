class Place < ActiveRecord::Base
  attr_accessible :name, :notes, :route_id
  has_many :activities, dependent: :destroy
  validates :name, :route_id, presence: true
  validates :name, uniqueness: true
end
