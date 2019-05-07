# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
	let(:user) { build(:user) }
	describe "ASSOCIATIONS" do
		it { should have_many(:comments).dependent(:destroy) }
		it { should have_many(:posts).dependent(:destroy) }
		it { should have_many(:purchase_orders).dependent(:restrict_with_error).inverse_of(:buyer) }
		it { should have_many(:purchased_posts).through(:purchase_orders) }
		it { should have_many(:sales_orders).dependent(:restrict_with_error).inverse_of(:seller) }
	end

	describe "VALIDATIONS" do
		it { should validate_uniqueness_of(:username) }
	end

	describe "INSTANCE METHODS" do
		describe "#name" do
			it "returns a users first name and last name combined" do
				expect(user.name).to eq("#{user.first_name} #{user.last_name}")
			end
		end
	end
end
