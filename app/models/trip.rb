class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :routes, dependent: :destroy
  has_many :major_places, class_name: :Place, conditions: {parent_id: nil}
  has_many :places
  attr_accessible :description, :name, :user_id, :start_date, :end_date
  validates :name, :user_id, presence: true
  validates :name, length: {maximum: 40}
  validates_uniqueness_of :name, scope: :user_id
end
