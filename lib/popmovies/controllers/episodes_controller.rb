require_relative '../utils'
require_relative '../views/episode_view'
require_relative '../models/episode'

module Popmovies
  module Controllers
    class EpisodesController
      include Views
      include Models

      EPISODES_CSS_SELECTOR = "div.filmborder div.filmcontent div.keremiya_part"

      def initialize router
        @episode_view = EpisodeView.new router
      end

      def index season
        @episodes = fetch_datas season
        @episode_view.update @episodes
        @episode_view.render
      end

      def fetch_datas season
        # TODO : test it !!
        # check the resule of fetch_html_page and page.css
        # depends on Exception thrown by nokogiri and open-uri on Utils class
        page = Utils.fetch_html_page season.url
        html_episodes_tmp = page.css EPISODES_CSS_SELECTOR
        html_episodes = html_episodes_tmp.xpath('./a')

        episodes = []
        # ugly but no choice
        episodes << Episode.new("Episode 1", season.url)
        html_episodes.each do |episode|
          episode_title = episode.css("span").text
          episode_url = episode['href']
          episodes << Episode.new(episode_title, episode_url)
          # TODO add episodes to tv_show.episode
          # tv_show.seasons << seasons
        end
        return episodes
      end

    end
  end
end