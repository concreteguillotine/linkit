class Post < ApplicationRecord
    acts_as_votable
    has_one_attached :image
    has_many :comments, dependent: :destroy
    belongs_to :author, class_name: "User"
    has_and_belongs_to_many :tags
end
