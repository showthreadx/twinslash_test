class Ad < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  enum status: [:draft_ad, :new_ad, :canceled_ad, :approved_ad, :published_ad, :archived_ad]
  enum category: [:default, :category_first, :category_second]
  after_initialize do
    if self.new_record?
      self.status ||= :draft_ad
      self.category ||= :default
    end
  end
end
