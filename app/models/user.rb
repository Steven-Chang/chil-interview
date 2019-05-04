# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  # === ASSOCIATIONS ===
  has_many :comments, as: :author, dependent: :destroy
  has_many :posts,
           foreign_key: "author_id",
           dependent: :destroy,
           inverse_of: :author

  # === VALIDATIONS ===
  validates :username, uniqueness: true

  # === INSTANCE METHODS ===
  def name
    "#{first_name} #{last_name}"
  end
end
