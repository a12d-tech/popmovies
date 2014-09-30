require 'spec_helper'
require_relative "../../lib/popmovies/utils"
require_relative "../../lib/popmovies/models/tv_show"
require_relative "../../lib/popmovies/views/error_view"
require_relative "../../lib/popmovies/error"

module Popmovies
  include Views
  include Models

  describe Utils do

    describe "#data_type" do
      it "method present?" do
        expect(Utils).to respond_to(:data_type)
      end

      it "returns class name of first object in array" do
        array = []
        3.times { |i| array << TvShow.new("Dallas", "url_#{i}")}
        expect(Utils.data_type array).to be == "TvShow"
      end

      it "returns nil if array.empty?" do
        array = []
        expect(Utils.data_type array).to be nil
      end
    end

    describe "#fetch_html_page" do
      it "method present?" do
        expect(Utils).to respond_to(:fetch_html_page)
      end

      context "when bad url" do
        # before { allow_any_instance_of(ErrorView).to receive(:show).and_return(true) }
        # before { allow(Kernel).to receive(:abort).and_return(true) }
        before :all do
          @bad_url = "http://www.test.olive"
        end

        it "raises ConnectionError" do
          expect{Utils.fetch_html_page @bad_url}.to raise_error(ConnectionError,"Check your internet connection!")
        end

        # it "render ErrorView" do
        #   Utils.fetch_html_page @bad_url
        #   expect(ErrorView).to receive(:new).with("Check your internet connection!")
        # end
      end

    end
  end
end
