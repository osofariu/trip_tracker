class Place < ActiveRecord::Base
  attr_accessible :name, :notes
  has_many :activities, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
end
