module Popmovies
  module Models
    class TvShow

      attr_accessor :title, :url, :seasons

      def initialize title, url
        @title = title
        @url = url
        @seasons = []
      end

    end
  end
end