class User < ApplicationRecord
  has_many :ads
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
