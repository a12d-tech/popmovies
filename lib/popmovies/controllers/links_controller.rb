require_relative '../views/link_view'
require_relative '../models/link'

module Popmovies
  module Controllers
    class LinksController < Controller
      include Views
      include Models
      include Config

      CSS_SELECTOR = WEB[:links_css_selector]

      def initialize
        super
        @link_view = LinkView.new
      end

      def render(episode)
        @links =
          fetch_datas(episode.url, CSS_SELECTOR) do |html_tags|
            html_tags = html_tags.xpath("./p//iframe[contains(@src,'embed')]")
            html_tags.map { |link_url| Link.new(link_url['src']) }
          end

        @link_view.populate_with(@links)
        @link_view.render

        @router.trigger(:exit)
      end

    end
  end
end
