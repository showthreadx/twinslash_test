class Ad < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  belongs_to :ad_type
  enum status: [:draft_ad, :new_ad, :canceled_ad, :approved_ad, :published_ad, :archived_ad]
  after_initialize do
    if self.new_record?
      self.status ||= :draft_ad
    end
  end
end
