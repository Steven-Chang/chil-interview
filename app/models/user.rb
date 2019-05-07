# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  # === ASSOCIATIONS ===
  has_many :comments, as: :author, dependent: :destroy
  has_many :posts,
           foreign_key: "author_id",
           dependent: :destroy,
           inverse_of: :author

  has_many :purchase_orders,
           foreign_key: "buyer_id",
           class_name: "Order",
           dependent: :restrict_with_error,
           inverse_of: :buyer
  has_many :purchased_posts,
           through: :purchase_orders,
           class_name: "Post"

  has_many :sales_orders,
           foreign_key: "seller_id",
           class_name: "Order",
           dependent: :restrict_with_error,
           inverse_of: :seller

  # === VALIDATIONS ===
  validates :username, uniqueness: true

  # === INSTANCE METHODS ===
  def name
    "#{first_name} #{last_name}"
  end
end
