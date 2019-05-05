# frozen_string_literal: true

require "rails_helper"

RSpec.describe "display comments on a posts show page", type: :feature do
	let!(:post_with_comments) { create(:post_with_comments) }

	context "when on a posts page" do
		before do
			visit post_path(post_with_comments)
		end

		context "when post has comments" do
			it "displays the posts comments" do
				expect(page).to have_text(post_with_comments.comments.first.body)
			end

			context "when comment has comments" do
				let(:comment_body) { "Avengers was pretty good." }
				before do
					create(:comment, body: comment_body, commentable: post_with_comments.comments.first)
					puts post_with_comments.comments.first
					visit post_path(post_with_comments)
				end

				it "displays the comment's comments" do
					expect(page).to have_text(comment_body)
				end
			end
		end
	end
end
