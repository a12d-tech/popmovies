module Popmovies
  module Controllers
    class Controller

      protected

      def fetch_datas url, css_selector
        begin
          page = Utils.fetch_html_page url
          html_selected_tags = page.css css_selector

          raise RemoteError, "It seems broken! Sorry" if html_selected_tags.empty?

          return yield(html_selected_tags) if block_given?

        rescue RemoteError, ConnectionError => e
          e.handle
        end
      end

    end
  end
end