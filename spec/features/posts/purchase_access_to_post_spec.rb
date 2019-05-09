# frozen_string_literal: true

require "rails_helper"

RSpec.describe "purchase access on a posts show page", type: :feature, js: true do
	let!(:post_with_comments) { create(:post_with_comments) }
	let(:non_author_user) { create(:user) }
	let!(:subscription_option) { create(:subscription_option, subscribable_type: "Site") }

	context "when author is logged in" do
		before do
			login_as(post_with_comments.author)
		end

		context "when on author's post page" do
			before do
				visit post_path(post_with_comments)
			end

			it "hides the payment-form" do
				expect(page).not_to have_selector("#post-purchase-form-container")
			end
		end
	end

	context "when non-author is logged in" do
		before do
			login_as(non_author_user)
		end

		context "when on a post page" do
			before do
				visit post_path(post_with_comments)
				sleep 2
			end

			context "when user doesn't have access to this post" do
				it "shows the payment form" do
					expect(page).to have_selector("#post-purchase-form-container")
				end

				context "when user successfully purchases access" do
					before do
	          stripe_iframe = all("iframe").last
	          Capybara.within_frame stripe_iframe do
	            page.find_field("Card number").set "4000000360000006"
	            page.find_field("MM / YY").set "12/42"
	            page.find_field("CVC").set "123"
	          end
	          click_on "Submit Payment"
	          sleep 15
					end

					it "displays a success message" do
						expect(page).to have_selector(".notification__notice")
					end

					it "hides the payment form" do
						expect(page).not_to have_selector("#post-purchase-form-container")
					end

					it "shows the post's entire body" do
						expect(page).to have_text(post_with_comments.body)
					end
				end

				context "when purchase is unsuccessful" do
					it "displays an error flash message" do
						subscription_option.update(price: 0)
						visit post_path(post_with_comments)
	          stripe_iframe = all("iframe").last
	          Capybara.within_frame stripe_iframe do
	            page.find_field("Card number").set "5200828282828210"
	            page.find_field("MM / YY").set "12/42"
	            page.find_field("CVC").set "345"
	            sleep 1
	            page.find_field("ZIP").set "10001"
	          end
	          click_on "Submit Payment"
	          sleep 10
						expect(page).to have_selector(".notification__alert")
					end
				end
			end
		end
	end
end
