# frozen_string_literal: true

require "rails_helper"

RSpec.describe "display number of comments on post", type: :feature do
	let(:tag_name) { "the" }
	let!(:post_with_comments) { create(:post_with_comments, tag_list: [tag_name]) }

	describe "home page" do
	  it "shows number of comments for each post" do
	  	visit root_path
	  	expect(find(".post__meta-comments").text).to eq("#{post_with_comments.comments.count} Comments")
	  end
	end

	describe "post page" do
		it "shows number of comments for each post" do
	  	visit post_path(post_with_comments)
	  	expect(find(".post__meta-comments").text).to eq("#{post_with_comments.comments.count} Comments")
		end
	end

	describe "tags page" do
		it "shows number of comments for each post" do
			visit tag_path(tag_name)
			expect(find(".post__meta-comments").text).to eq("#{post_with_comments.comments.count} Comments")
		end
	end
end
