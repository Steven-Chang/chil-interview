# frozen_string_literal: true

require "rails_helper"

RSpec.describe Order, type: :model do
	let!(:order) { create(:order) }

	describe "ASSOCIATIONS" do
		it { should belong_to(:post) }
		it { should belong_to(:buyer).class_name("User") }
		it { should belong_to(:seller).class_name("User") }
	end

	describe "VALIDATIONS" do
		it { should validate_uniqueness_of(:post_id).scoped_to([:buyer_id, :seller_id]) }
	end
end
