# frozen_string_literal: true

require "rails_helper"

RSpec.describe Purchase, type: :model do
	let!(:purchase) { create(:purchase) }

	describe "ASSOCIATIONS" do
		it { should belong_to(:purchasable) }
		it { should have_many(:tranxactions).dependent(:restrict_with_error) }
		it { should belong_to(:user) }
	end

	describe "VALIDATIONS" do
		it { should validate_uniqueness_of(:user_id).scoped_to([:purchasable_type, :purchasable_id]) }
	end
end
