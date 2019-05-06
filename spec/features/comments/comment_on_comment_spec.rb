# frozen_string_literal: true

require "rails_helper"

RSpec.describe "comment on comment", type: :feature, js: true do
	let!(:post_with_comments) { create(:post_with_comments) }
	let(:comment) { post_with_comments.comments.first }

	context "when user on post page" do
		context "when user is not logged in" do
			context "when user clicks reply" do
				it "redirects user to login page" do
					visit post_path(post_with_comments)
					expect(current_path).to eq(post_path(post_with_comments))
					page.all(".reply-text")[1].click
					expect(current_path).to eq(login_path)
				end
			end
		end

		context "when user is logged in" do
			before do
				login_as(post_with_comments.author)
				visit post_path(post_with_comments)
			end

			context "when user clicks on reply for a comment" do
				before do
					within("#comment-#{comment.id}") do
						expect(page).not_to have_selector("#comment-#{comment.id}-comment-form")
						page.all(".reply-text").first.click
					end
				end

				it "displays the comment form for that comment" do
					expect(page).to have_selector("#comment-#{comment.id}-comment-form")
				end

				it "lets user comment on that comment" do
					within("#comment-#{comment.id}") do
						fill_in "comment[body]", with: "Nugs in 7"
						click_button "Create Comment"
						expect(page).to have_content("Nugs in 7")
					end
				end
			end
		end
	end
end
