class Post < ApplicationRecord
  belongs_to :user
  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy 

  has_one_attached :image

  validates :title, presence: true
  validates :image, presence: true

  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
      self.tags << post_tag
    end
  end

  def favorite?(user)
    favorites.where(user_id: user.id).exists?
  end
end
