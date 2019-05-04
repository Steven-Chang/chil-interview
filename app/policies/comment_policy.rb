# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    user.present? && record.author == user
  end
end
