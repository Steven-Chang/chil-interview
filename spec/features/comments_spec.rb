# frozen_string_literal: true

require "rails_helper"

RSpec.describe "comments", type: :feature, js: true do
	let!(:post) { create(:post) }

	describe "post page" do
		it "lets logged in user to comment on the pos via ajax"
		it "doesn't let non logged in user to comment on post via ajax"
		it "lets user to comment on another comment via ajax"
	end
end
