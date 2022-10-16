class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: "User"

  validates :text, presence: true, length: { maximum: 100 }

  scope :persisted, -> { where.not(id: nil) }
  scope :ordered, -> { order(created_at: :asc) }
end
