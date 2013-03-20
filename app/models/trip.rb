class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :routes, dependent: :destroy
  attr_accessible :description, :name, :user_id
  validates :name, :user_id, presence: true
  validates :name, length: {maximum: 40}
  validates_uniqueness_of :name, scope: :user_id
end
