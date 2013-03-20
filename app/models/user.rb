class User < ActiveRecord::Base
  has_many :trips, dependent: :destroy
  attr_accessible :name, :password_digest
  validates :name, :password_digest, presence: true
end
