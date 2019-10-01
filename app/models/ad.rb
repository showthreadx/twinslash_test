class Ad < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_title_and_description, against: %i[title description],
  using: {
    tsearch: { prefix: true }
  }

  def self.search(query)
    if query.present?
      search_by_title_and_description(query)
    else
      # No query? Return all records, newest first.
      order("created_at DESC")
    end
  end

  scope :new_ads, -> {
    where(status: 'new_ad')
  }

  validates :title, presence: true, length: { maximum: 15 }
  validates :description, :user_id, :ad_type_id, presence: true

  has_many_attached :images
  belongs_to :user
  belongs_to :ad_type

  enum status: %i[draft_ad new_ad canceled_ad approved_ad published_ad archived_ad]
  after_initialize do
    self.status ||= :draft_ad if self.new_record?
  end
end
