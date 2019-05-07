# frozen_string_literal: true

require "rails_helper"

RSpec.describe "create post", type: :feature do
  let!(:post) { create(:post) }

  it "login required to create post" do
    visit new_post_path
    expect(current_path).to eq(login_path)
    expect(page).to have_selector(".notification__alert", text: I18n.t("login_required"))
  end

  it "creates new post" do
    login_as(post.author)

    click_link "New Post"
    fill_in "post[title]", with: "RSpec"
    fill_in "post[body]", with: "RSpec"
    click_button "Create Post"

    expect(current_path).to eq(post_path(Post.last))
    expect(Post.last.author).to eq(post.author)
    expect(page).to have_selector(".post__title", text: "RSpec")
    expect(page).to have_selector(".post__body", text: "RSpec")
  end
end
