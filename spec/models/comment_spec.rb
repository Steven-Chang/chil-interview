# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
	describe "ASSOCIATIONS" do
		it { should belong_to(:post) }
		it { should belong_to(:author).class_name("User") }
	end

	describe "VALIDATIONS" do
		it { should validate_presence_of(:body) }
		it { should validate_presence_of(:author_id) }
		it { should validate_presence_of(:post_id) }
	end
end
