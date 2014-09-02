require_relative '../utils'
require_relative '../views/link_view'
require_relative '../models/link'

module Popmovies
  module Controllers
    class LinksController
      include Views
      include Models

      LINKS_CSS_SELECTOR = "div.filmborder div.filmcontent div.filmicerik"

      def initialize router
        @link_view = LinkView.new router
      end

      def index episode
        @links = fetch_datas episode
        @link_view.update @links
        @link_view.render
      end

      def fetch_datas episode
        # TODO : test it !!
        # check the resule of fetch_html_page and page.css
        # depends on Exception thrown by nokogiri and open-uri on Utils class
        page = Utils.fetch_html_page episode.url
        html_links_tmp = page.css LINKS_CSS_SELECTOR
        html_links = html_links_tmp.xpath("./p//iframe[contains(@src,'embed')]")

        links = []
        html_links.each do |link_url|
          links << Link.new(link_url['src'])
        end
        return links
      end
    end
  end
end