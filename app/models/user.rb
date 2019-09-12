class User < ApplicationRecord
  enum role: [:guest, :user, :admin]
  after_initialize do
    if self.new_record?
      self.role ||= :user
    end
  end
  has_many :ads
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
