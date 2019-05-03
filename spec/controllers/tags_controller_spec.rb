# frozen_string_literal: true

require "rails_helper"

RSpec.describe TagsController, type: :controller do
	let(:tag_name) { "tag" }

  describe "GET #show" do
  	before { get :show }

  	it { should render_template("show") }

		it "returns http success" do
      expect(response).to have_http_status(:success)
		end

		describe "ASSIGNS" do
			describe "@posts" do
				it "assigns posts" do
					expect(assigns(:posts)).not_to be_nil
				end

				context "when tagged posts exists" do
					before do
						post = create(:post)
						post.tag_list = tag_name
						post.save!
					end

					it "assigns posts with posts tagged with related tag name" do
						get :show, params: { name: tag_name }
						expect(assigns(:posts)).to eq(Post.tagged_with(tag_name))
					end
				end
			end
		end
  end
end
