require 'spec_helper'
require_relative "../lib/popmovies/utils"

module Popmovies
  describe Utils do
    context "#fetch_html_page" do

      it "to return false when bad url" do
        expect(Utils.fetch_html_page("http://www.test.olive")).to be false
      end

    end
  end
end
