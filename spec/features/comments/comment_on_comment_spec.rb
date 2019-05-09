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
					page.all(".reply-text").first.click
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
					sleep 1
					within("#comment-#{comment.id}") do
						expect(page).not_to have_selector("#comment-#{comment.id}-comment-form")
						all(".reply-text").first.click
					end
					sleep 1
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

				context "when user clicks on cancel for a comments comment form" do
					it "hides the comment form" do
						within("#comment-#{comment.id}") do
							fill_in "comment[body]", with: "Nugs in 7"
							click_button "Cancel"
						end
						expect(page).not_to have_selector("#comment-#{comment.id}-comment-form")
					end
				end

				context "when user comments on comment" do
					let(:comments_count_before_create) { post_with_comments.comments.count }
					before do
						sleep 1
						within("#comment-#{comment.id}") do
							fill_in "comment[body]", with: "Nugs in 7"
							click_button "Create Comment"
						end
						sleep 2
					end

					it "adds the newly created comment to page" do
						expect(page).to have_content("Nugs in 7")
					end

					it "doesn't change the post's comment count" do
						expect(page.first(".comments-counter").text.split(" ").first.to_i).to eq(comments_count_before_create)
					end

					it "resets the comment form" do
						sleep 1
						within("#comment-#{comment.id}") do
							page.all(".reply-text").first.click
						end
						expect(page.find("#comment-#{comment.id}-comment-form")).to have_field("comment[body]", with: "")
					end

					it "hides the comment form" do
						expect(page).not_to have_selector("#comment-#{comment.id}-comment-form")
					end

					context "when user clicks on reply for a freshly created comment" do
						before do
							sleep 1
							within("#comment-#{Comment.last.id}") do
								find(".reply-text").click
							end
						end

						it "shows a comment form for that comment" do
							expect(page).to have_selector("#comment-#{Comment.last.id}-comment-form")
						end
					end
				end
			end
		end
	end
end
