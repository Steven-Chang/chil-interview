# frozen_string_literal: true

require "rails_helper"

RSpec.describe "display post on a posts show page", type: :feature do
	let!(:post_with_comments) { create(:post_with_comments) }
	let(:non_author_user) { create(:user) }

	context "when user is not logged in" do
		context "when on a posts page" do
			before do
				visit post_path(post_with_comments)
			end

			it "shows a truncated post" do
				expect(current_path).to eq(post_path(post_with_comments))
				expect(page).to have_text(post_with_comments.body.truncate(300, omission: "..."))
				expect(page).not_to have_text(post_with_comments.body[301..400])
			end

			it "shows a login to get full article link" do
				expect(page).to have_link("Please login to access full article")
			end

			context "when user clicks on the login to access full article link" do
				it "redirects the user to the login page" do
					click_link "Please login to access full article"
					expect(current_path).to eq(login_path)
				end
			end
		end
	end

	context "when author is logged in" do
		before do
			login_as(post_with_comments.author)
		end

		context "when on author's post page" do
			before do
				visit post_path(post_with_comments)
			end

			it "hides the login to get full article link" do
				expect(page).not_to have_link("Please login to access full article")
			end

			context "when user is the author" do
				it "shows the post's entire body" do
					expect(page).to have_text(post_with_comments.body)
				end
			end
		end
	end

	context "when non-author is logged in" do
		before do
			login_as(non_author_user)
		end

		context "when on a post page" do
			before do
				visit post_path(post_with_comments)
			end

			it "hides the login to get full article link" do
				expect(page).not_to have_link("Please login to access full article")
			end

			it "shows a truncated post" do
				expect(current_path).to eq(post_path(post_with_comments))
				expect(page).to have_text(post_with_comments.body.truncate(300, omission: "..."))
				expect(page).not_to have_text(post_with_comments.body[301..400])
			end
		end
	end
end
