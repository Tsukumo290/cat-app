class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  
  mount_uploader :image, ImageUploader

  validates :nickname, presence: true
  validates :profile, length: { maximum: 250 }
end
