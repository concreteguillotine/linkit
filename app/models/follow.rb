class Follow < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :tag

    validates :follower_id, uniqueness: { scope: :tag_id }
    validates :tag_id, uniqueness: { scope: :follower_id }
end
