# frozen_string_literal: true

class Api::V1::CommentsController < ApplicationController
	def create
    @comment = Comment.new(permitted_params)
    @comment.author = current_user
    authorize @comment, :create?

    if @comment.save
      options = {}
      options[:include] = [:author]
      render json: CommentSerializer.new(@comment, options), status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
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
