class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, foreign_key: 'author_id'
  has_many :Comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  ROLES = %i[admin default].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  def confirmed_at
    DateTime.now
  end

  def confirmed_at=(val); end
end
