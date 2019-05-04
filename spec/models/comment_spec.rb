# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
	describe "ASSOCIATIONS" do
		it { should belong_to(:commentable) }
		it { should belong_to(:author).class_name("User") }
		it { should have_many(:comments).dependent(:destroy) }
	end

	describe "VALIDATIONS" do
		it { should validate_presence_of(:body) }
	end
end
