# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing", type: :routing do
  describe "tags" do
    it do
      tag_name = "some-tag"
      should route(:get, "/tags/#{tag_name}")
        .to("tags#show", name: tag_name)
    end
  end
end
