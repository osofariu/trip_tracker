class User < ActiveRecord::Base
  has_many :trips, dependent: :destroy
  attr_accessible :name, :password, :password_confirmation
  validates :name,  presence: true, uniqueness: true
  has_secure_password
end
