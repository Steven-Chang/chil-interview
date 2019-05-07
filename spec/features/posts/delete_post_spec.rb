# frozen_string_literal: true

require "rails_helper"

RSpec.describe "delete post", type: :feature do
	let!(:post) { create(:post) }

	it "allows author to remove their post" do
	  login_as(post.author)

	  visit post_path(post)

	  expect { click_link "Delete" }.to change(Post, :count).by(-1)
	  expect(current_path).to eq(root_path)
	  expect(page).to have_selector(".notification__notice", text: I18n.t("posts.destroy.success"))
	end
end
