require_relative '../utils'
require_relative '../views/link_view'
require_relative '../models/link'

module Popmovies
  module Controllers
    class LinksController < Controller
      include Views
      include Models

      def initialize router
        super()
        @link_view = LinkView.new router
      end

      def index episode
        @links = fetch_datas(episode.url, Config::WEB[:links_css_selector]){
          # filter links
          @html_selected_tags = @html_selected_tags.xpath("./p//iframe[contains(@src,'embed')]")

          links = []
          @html_selected_tags.each { |link_url| links << Link.new(link_url['src']) }
          @datas = links
        }
        @link_view.update @links
        @link_view.render
      end

    end
  end
end