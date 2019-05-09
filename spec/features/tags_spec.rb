# frozen_string_literal: true

require "rails_helper"

RSpec.describe "tags", type: :feature, js: true do
	let(:tag_name) { "horses" }
	let!(:post_with_tag) { create(:post, tag_list: [tag_name]) }
	let(:tag_name_two) { "on" }
	let(:post_two) { create(:post) }

	describe "tags show page" do
		before do
			visit tag_path(name: tag_name)
		end

		describe "displaying posts" do
		  it "lists posts, on the tag's page with a border" do
		  	expect(page).to have_selector(".post--border")
		  end

		  it "lists posts, on the tag's page with the title as a link" do
		  	expect(page).to have_link post_with_tag.title, href: post_path(post_with_tag)
		  end

		  it "doesn't list unrelated posts on the tag's page" do
		  	expect(page)
		  	  .not_to have_link(post_two.title, href: post_path(post_two))
		  end
		end

		describe "displaying tags on posts" do
		  it "displays a posts tags as a link" do
				expect(page).to have_link(tag_name, href: tag_path(name: tag_name))
		  end

		  it "doesn't display unrelated tags for a post" do
		  	post_two.tag_list.add(tag_name_two)
		  	post_two.save
		  	visit tag_path(name: tag_name_two)
		  	expect(page).not_to have_link(tag_name, href: tag_path(name: tag_name))
		  end
		end
	end

	describe "home page" do
	  it "displays a posts tags as a link" do
	  	visit root_path
			expect(page).to have_link(tag_name, href: tag_path(name: tag_name))
	  end
	end

	describe "post page" do
	  it "displays a posts tags as a link" do
	  	post_with_tag.tag_list.add(tag_name_two)
	  	post_with_tag.save
	  	visit post_path(post_with_tag)
			expect(page).to have_link(tag_name, href: tag_path(name: tag_name))
			expect(page).to have_link(tag_name_two, href: tag_path(name: tag_name_two))
	  end

		it "doesn't list unrelated tags for post on post page" do
			post_two.tag_list.add(tag_name_two)
			post_two.save
			visit post_path(post_with_tag)
			expect(page)
			  .not_to have_link(tag_name_two, href: tag_path(name: tag_name_two))
		end
	end

	describe "adding tags while creating post" do
		it "allows author of post to add tags while creating post" do
			login_as(post_with_tag.author)
	    click_link "New Post"
	    fill_in "post[title]", with: "RSpec"
	    fill_in "post[body]", with: "RSpec"
	    sleep 1
			find(".ui-widget-content .ui-autocomplete-input").set(tag_name)
			click_button "Create Post"
			expect(page)
			  .to have_link(tag_name, href: tag_path(name: tag_name))
		end
	end

	describe "changing tags while editing post" do
		before do
	    login_as(post_with_tag.author)
	    visit post_path(post_with_tag)
	    sleep 2
	    click_link "Edit"
		end
	  it "allows author of post to add tags" do
	  	find(".ui-widget-content .ui-autocomplete-input").set(tag_name_two)
	  	click_button "Update Post"
			expect(page)
			  .to have_link(tag_name_two, href: tag_path(name: tag_name_two))
	  end

	  it "allows author of post to remove tags" do
	  	find("a.tagit-close").click
	  	sleep 1
	  	click_button "Update Post"
	  	expect(page).not_to have_link(tag_name, href: tag_path(name: tag_name))
	  end
	end
end
