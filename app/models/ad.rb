class Ad < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  enum status: [:canceled, :pending, :saved, :approved]
  after_initialize do
    if self.new_record?
      self.status ||= :saved
    end
  end
end
