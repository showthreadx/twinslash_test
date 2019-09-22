class AdType < ApplicationRecord
  validates :name, uniqueness: true
  has_many :ads
end
