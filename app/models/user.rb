class User < ApplicationRecord
  validates :email, :password, presence: true
  has_many :ads
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
