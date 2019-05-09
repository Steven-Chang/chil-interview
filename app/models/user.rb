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
  has_many :subscriptions,
           through: :purchases,
           source_type: "Subscription",
           source: :purchasable

  # === VALIDATIONS ===
  validates :username, uniqueness: true
  validates :email, uniqueness: { case_sensitive: false }

  # === INSTANCE METHODS ===
  def authored_post?(post)
    posts.include?(post)
  end

  def active_subscription_to_post?(post)
    subscriptions
      .where(active: true)
      .find_by(subscribable: post)
      .present?
  end

  def active_subscription_to_site?
    subscriptions
      .where(active: true)
      .where(subscribable_type: "Site")
      .present?
  end

  def can_view_full_post?(post)
    authored_post?(post) || active_subscription_to_site? || active_subscription_to_post?(post)
  end

  def name
    "#{first_name} #{last_name}"
  end
end
