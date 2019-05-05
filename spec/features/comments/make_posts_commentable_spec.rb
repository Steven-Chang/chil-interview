# frozen_string_literal: true

require "rails_helper"

RSpec.describe "comment on post", type: :feature, js: true do
	let!(:post) { create(:post) }

	describe "post page" do
		it "lets logged in user to comment on the post via ajax"
		it "doesn't let non logged in user to comment on post via ajax"
		it "increases the comment count on the post after create"
	end
end
