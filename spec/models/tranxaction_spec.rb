# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tranxaction, type: :model do
	describe "ASSOCIATIONS" do
		it { should belong_to(:purchase) }
		it { should validate_numericality_of(:amount) }
	end
end
