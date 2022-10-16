class Post < ApplicationRecord
    acts_as_votable
    has_one_attached :image
    has_many :comments, dependent: :destroy

    after_update_commit -> { broadcast_update_later_to "posts/unvote", partial: "posts/vote", locals: { posts: self }}
    after_update_commit -> { broadcast_update_later_to "posts/vote", partial: "posts/unvote", locals: { posts: self }}

end
