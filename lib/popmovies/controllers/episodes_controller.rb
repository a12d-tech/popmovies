require_relative '../utils'
require_relative '../views/episode_view'
require_relative '../models/episode'

module Popmovies
  module Controllers
    class EpisodesController < Controller
      include Views
      include Models

      def initialize router
        super()
        @episode_view = EpisodeView.new router
      end

      def index season
        @episodes = fetch_datas(season.url, Config::WEB[:episodes_css_selector]){
          # specific tmp !! to remove
          @html_selected_tags = @html_selected_tags.xpath('./a')

          episodes = []
          # ugly but no choice
          episodes << Episode.new("Episode 1", season.url)
          @html_selected_tags.each do |episode|
            episode_title = episode.css("span").text
            episode_url = episode['href']
            episodes << Episode.new(episode_title, episode_url)
            # TODO add episodes to tv_show.episode
            # tv_show.seasons << seasons
          end
          @datas = episodes
        }
        @episode_view.update @episodes
        @episode_view.render
      end

    end
  end
end