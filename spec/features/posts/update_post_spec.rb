# frozen_string_literal: true

require "rails_helper"

RSpec.describe "update post", type: :feature do
  let!(:post) { create(:post) }
  
  it "allows author to update their post" do
    login_as(post.author)

    visit post_path(post)
    click_link "Edit"
    fill_in "post[title]", with: "New Title"
    click_button "Update Post"

    expect(current_path).to eq(post_path(post))
    expect(page).to have_selector(".post__title", text: "New Title")
  end

  it "doesn't allow update to someone else's post" do
    rouge_author = create(:user, username: "rouge")
    login_as(rouge_author)

    visit edit_post_path(post)

    expect(current_path).to eq(root_path)
    expect(page).to have_selector(".notification__alert", text: I18n.t("unauthorized"))
  end
end
