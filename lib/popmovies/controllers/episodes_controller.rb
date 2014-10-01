require_relative '../utils'
require_relative '../views/episode_view'
require_relative '../models/episode'

module Popmovies
  module Controllers
    class EpisodesController < Controller
      include Views
      include Models

      def initialize router
        @episode_view = EpisodeView.new router
      end

      def index season
        @episodes = fetch_datas(season.url, Config::WEB[:episodes_css_selector]) do |html_tags|
          # specific tmp !! to remove
          html_tags = html_tags.xpath('./a')

          tmp = html_tags.map { |episode| Episode.new(episode.css("span").text, episode['href']) }
          # TODO add episodes to tv_show.episode
          # tv_show.seasons << seasons

          # ugly but no choice
          [Episode.new("Episode 1", season.url), tmp].flatten
        end
        @episode_view.update @episodes
        @episode_view.render
      end

    end
  end
end