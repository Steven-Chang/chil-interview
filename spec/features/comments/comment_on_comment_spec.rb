# frozen_string_literal: true

require "rails_helper"

RSpec.describe "comment on comment", type: :feature, js: true do
	let!(:post) { create(:post) }

	describe "post page" do
		it "lets logged in user to comment on a comment via ajax"
		it "doesn't let non logged in user to comment on a comment via ajax"
	end
end
