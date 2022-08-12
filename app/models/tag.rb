class Tag < ApplicationRecord
  has_many   :tag_relationships, dependent: :destroy
  has_many   :posts, through: :tag_relationships
  validates :name, uniqueness: true

  def self.search(search)
    if search != nil
      tag = Tag.where(name: search)
      if tag.count != 0
      tag[0].posts
      else
        Post.order(created_at: :desc)
      end
    else
      Post.order(created_at: :desc)
    end
  end
end
