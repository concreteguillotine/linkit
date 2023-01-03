class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  acts_as_voter

  has_one_attached :image, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # following tags
  has_many :followed_tags, foreign_key: :follower_id, class_name: 'Follow'
  has_many :tags, through: :followed_tags

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  def email_changed?
    false
  end

  def email_required?
    false
  end
end
