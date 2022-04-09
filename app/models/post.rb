class Post < ApplicationRecord
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all

  belongs_to :author, class_name: 'User'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_post_counter

  def update_post_counter
    author.update(posts_counter: author.posts.size)
  end

  def recent_comments
    comments.last(5)
  end
end
