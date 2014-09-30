module Popmovies
  module Controllers
    class Controller

      def initialize
        @html_selected_tags = []
        @datas = nil
      end

      protected

      def fetch_datas url, css_selector
        begin
          page = Utils.fetch_html_page url
          @html_selected_tags = page.css css_selector

          raise RemoteError, "It seems broken! Sorry" if @html_selected_tags.empty?

          yield self if block_given?

          return @datas

        rescue RemoteError, ConnectionError => e
          e.handle
        end
      end

    end
  end
end