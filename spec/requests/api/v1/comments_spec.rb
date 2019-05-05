# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Comments", type: :request do
  let!(:post_one) { create(:post) }
  let(:user) { create(:user) }

  describe "create" do
    context "when user isn't signed in" do
      it "doesn't create a post" do
        post "/api/v1/comments", params: {
          comment: {
            body: "Bucks 2019",
            commentable_type: post_one.class.to_s,
            commentable_id: post_one.id,
            author_id: post_one.author.id
          }
        }

        expect(response.status).to eq(401)
      end
    end

    context "when user is signed in" do
      before do
        post login_path, params: { username: user.username, password: user.password }
        post "/api/v1/comments", params: {
          comment: {
            body: "Bucks 2019",
            commentable_type: post_one.class.to_s,
            commentable_id: post_one.id
          }
        }
      end

      it "creates a Comment and returns the created comment as json" do
        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)["included"].first["id"]).to eq(user.id.to_s)
        expect(JSON.parse(response.body)["included"].first["type"]).to eq("user")
        expect(JSON.parse(response.body)["data"]["type"]).to eq("comment")
      end

      it "creates a Comment which belongs to user and returns the user's username" do
        expect(JSON.parse(response.body)["data"]["type"]).to eq("comment")
      end
    end
  end
end
