# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  # === ASSOCIATIONS ===
  has_many :comments, as: :author, dependent: :destroy
  has_many :purchases,
           dependent: :restrict_with_error,
           inverse_of: :user
  has_many :posts,
           foreign_key: "author_id",
           dependent: :destroy,
           inverse_of: :author
  has_many :purchased_posts,
           through: :purchases,
           source_type: "Post",
           source: :purchasable

  # === VALIDATIONS ===
  validates :username, uniqueness: true
  validates :email, uniqueness: { case_sensitive: false }

  # === INSTANCE METHODS ===
  def can_view_full_post?(post)
    posts.include?(post) || purchased_posts.include?(post)
  end

  def name
    "#{first_name} #{last_name}"
  end
end
