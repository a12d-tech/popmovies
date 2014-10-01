require_relative '../utils'
require_relative '../views/link_view'
require_relative '../models/link'

module Popmovies
  module Controllers
    class LinksController < Controller
      include Views
      include Models

      def initialize router
        @link_view = LinkView.new router
      end

      def index episode
        @links = fetch_datas(episode.url, Config::WEB[:links_css_selector]) do |html_tags|
          # filter links
          html_tags = html_tags.xpath("./p//iframe[contains(@src,'embed')]")
          html_tags.map { |link_url| Link.new(link_url['src']) }
        end
        @link_view.update @links
        @link_view.render
      end

    end
  end
end