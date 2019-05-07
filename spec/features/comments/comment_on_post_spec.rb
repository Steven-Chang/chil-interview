# frozen_string_literal: true

require "rails_helper"

RSpec.describe "comment on post", type: :feature, js: true do
	let!(:post) { create(:post) }

	context "when on a post's page" do
		before do
			visit post_path(post)
		end

		context "when user isn't signed in" do
			context "when user clicks on comment on post input" do
				it "redirects user to the login page" do
					find("input[type=text][name='comment[body]']").click
					expect(current_path).to eq(login_path)
				end
			end
		end

		context "when user is signed in" do
			before do
				login_as(post.author)
				visit post_path(post)
			end

			context "when user clicks on the post comment cancel button" do
				it "clears the post comment body input" do
					within("#post-#{post.id}-comment-form") do
						fill_in "comment[body]", with: "Nugs in 7"
						expect(page.find_field("comment[body]").value).to eq("Nugs in 7")
						click_on "Cancel"
						expect(page.find_field("comment[body]").value).to eq("")
					end
				end

				it "doesn't redirect the user out of the page" do
					click_button "Create Comment"
					expect(current_path).to eq(post_path(post))
				end
			end

			it "lets user to comment on the post" do
				expect(current_path).to eq(post_path(post))
				fill_in "comment[body]", with: "Bucks in 6"
				click_button "Create Comment"
				expect(page).to have_selector(".comment__body", text: "Bucks in 6")
			end

			it "increases the comment count for post when user creates a comment" do
				comments_count_before_create = post.comments.count
				fill_in "comment[body]", with: "Bucks in 6"
				click_button "Create Comment"
				expect(page.first(".comments-counter").text.split(" ").first.to_i).to eq(comments_count_before_create + 1)
			end

			it "resets the comment form when user creates a post" do
				fill_in "comment[body]", with: "Bucks in 6"
				click_button "Create Comment"
				expect(page).to have_field("comment[body]", with: "")
			end
		end
	end
end
