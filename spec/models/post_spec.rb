# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
	describe "ASSOCIATIONS" do
		it { should belong_to(:author).class_name("User") }
		it { should have_many(:comments).dependent(:destroy) }
	end

	describe "VALIDATIONS" do
		it { should validate_presence_of(:body) }
		it { should validate_presence_of(:title) }
	end

	describe "SCOPES" do
		describe ".ordered" do
			it "orders posts by updated_at descending" do
	      create(:post)
	      create(:post)
	      create(:post)
	      expect(Post.ordered).to eq(Post.order(updated_at: :desc))
			end
		end
	end
end
