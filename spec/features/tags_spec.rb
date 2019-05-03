# frozen_string_literal: true

require "rails_helper"

RSpec.describe "tags", type: :feature do
	let!(:post) { create(:post) }
	let(:tag_name) { "horses" }
	let(:untagged_post) { create(:post) }
	before do
		post.tag_list.add(tag_name)
		post.save
		post.reload
	end

  it "lists posts, on the tag's page with a border" do
  	visit tag_path(name: tag_name)

  	expect(page).to have_selector(".post--border")
  end

  it "lists posts, on the tag's page with the title as a link" do
  	visit tag_path(name: tag_name)

  	expect(page).to have_link post.title, href: post_path(post)
  end

  it "doesn't list unrelated posts on the tag's page" do
  	visit tag_path(name: tag_name)

  	expect(page).not_to have_link untagged_post.title, href: post_path(untagged_post)
  end

  it "lists tags for each post on home page"

  it "lists tags for post on post page"

  it "allows author of post to add tags while creating post"

  it "allows author of post to remove tags while creating post"

  it "allows author of post to add tags while editing post"

  it "allows author of post to remove tags while editing post"

  it "doesn't allow adding of tag to someone else's post"

  it "doesn't allow removing of tag to someone else's post"
end
