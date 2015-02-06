module Popmovies
  module Models
    class TvShow

      attr_accessor :title, :url

      def initialize(title, url)
        @title = title
        @url = url
      end

    end
  end
end
