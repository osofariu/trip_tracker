class User < ActiveRecord::Base
  has_many :trips, dependent: :destroy
  attr_accessible :name, :password, :password_confirmation
  validates :name,  presence: true, uniqueness: true
  validates :name, :password, :password_confirmation, length: {maximum: 40}
  has_secure_password
end
