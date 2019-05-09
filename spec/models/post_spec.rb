# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
	let(:post) { create(:post) }

	describe "ASSOCIATIONS" do
		it { should belong_to(:author).class_name("User") }
		it { should have_many(:subscriptions).dependent(:restrict_with_error) }
		it { should have_many(:comments).dependent(:destroy) }
	end

	describe "VALIDATIONS" do
		it { should validate_presence_of(:body) }
		it { should validate_presence_of(:title) }
	end

	describe "SCOPES" do
		describe ":ordered" do
			it "orders posts by updated_at descending" do
	      create(:post)
	      create(:post)
	      create(:post)
	      expect(Post.ordered).to eq(Post.order(updated_at: :desc))
			end
		end
	end

	describe "INSTANCE METHODS" do
		describe "#subscription_options" do
			it "calls SubscriptionOption.subscription_options_for_class with 'Post'" do
				expect(SubscriptionOption).to receive(:subscription_options_for_class).with("Post")
				post.subscription_options
			end
		end
	end
end
