require_relative '../router'
require_relative '../utils'
require_relative '../config'
require_relative '../error'

module Popmovies
  module Controllers
    class Controller

      attr_accessor :router

      def initialize
        @router = Router.new
      end

      protected

      def fetch_datas(url, css_selector, &block)
        page = Utils.fetch_html_page(url)

        html_selected_tags = page.css(css_selector)

        fail RemoteError if html_selected_tags.empty?

        block.call(html_selected_tags) if block_given?

      rescue RemoteError => e
        e.handle
      end

    end
  end
end
