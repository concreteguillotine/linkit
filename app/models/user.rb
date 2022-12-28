class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  acts_as_voter

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :followed_tags, foreign_key: :follower_id, class_name: 'Follow'
  has_many :tags, through: :followed_tags
  
  has_one_attached :image, dependent: :destroy

  def email_changed?
    false
  end

  def email_required?
    false
  end
end
