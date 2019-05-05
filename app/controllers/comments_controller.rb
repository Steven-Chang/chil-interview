# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(permitted_params)
    @comment.author = current_user
    authorize @comment, :create?

    respond_to do |format|
      @comment.save
      format.js
    end
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
