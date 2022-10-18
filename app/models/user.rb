class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  acts_as_voter
  has_many :posts
  has_one_attached :image

  def email_changed?
    false
  end

  def email_required?
    false
  end
end
