# frozen_string_literal: true

class TagsController < ApplicationController
  def show
  	@tag_name = params[:name]
  	@posts = Post.tagged_with(params[:name])
  end
end
