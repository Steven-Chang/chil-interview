# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :login_required, only: :create

  def create
    @comment = Comment.new(permitted_params)
    @comment.author = current_user
    authorize @comment, :create?
    @comment.save
  end

  private

  def permitted_params
    params.require(:comment).permit(
      :body,
      :commentable_id,
      :commentable_type
    )
  end
end
