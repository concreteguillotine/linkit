class Comment < ApplicationRecord
  acts_as_votable
  belongs_to :post
  belongs_to :author, class_name: "User"
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id

  validates :text, presence: true, length: { maximum: 100 }

  scope :persisted, -> { where.not(id: nil) }

  # scope for ordered by time created at
  scope :orderedt, -> { order(created_at: :asc) }

  # ordered by amount of votes
  scope :orderedl, -> { order(cached_votes_total: :desc) }
end
