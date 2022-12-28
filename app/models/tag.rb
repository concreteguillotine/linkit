class Tag < ApplicationRecord
    has_and_belongs_to_many :posts
    
    has_many :following_users, foreign_key: :tag_id, class_name: 'Follow'
    has_many :followers, through: :following_users
    
    def self.search(search)
        where("lower(tags.name) LIKE :search ", search: "%#{search.downcase}%").uniq
    end
end
