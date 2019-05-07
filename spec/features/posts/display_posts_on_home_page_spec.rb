# frozen_string_literal: true

require "rails_helper"

RSpec.describe "display posts on home page", type: :feature do
  let!(:post) { create(:post) }

  it "lists posts" do
    visit root_path

    expect(page).to have_selector(".post--border")
  end
end
