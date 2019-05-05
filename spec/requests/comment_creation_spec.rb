# frozen_string_literal: true

# This is only for authentication that can't be handled in integration tests

require "rails_helper"

RSpec.describe "Comment creation", type: :request do
  let!(:post_one) { create(:post) }
  context "when format is js" do
    it "returns unauthorized status if user is not logged in" do
      headers = {
        "ACCEPT" => "application/js"
      }
      post "/comments",
           params: {
             comment: {
               commentable_type: post_one.class.to_s,
               commentable_id: post_one.id,
               body: "Nate Diaz"
             }
           },
           headers: headers
      expect(response.status).to eq(401)
    end
  end
end
