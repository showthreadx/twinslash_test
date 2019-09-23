class User < ApplicationRecord
  validates :email, presence: true
  validates :password, length: { minimum: 6 }, on: :create
  has_many :ads
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
