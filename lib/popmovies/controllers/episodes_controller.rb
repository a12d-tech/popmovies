require_relative '../views/episode_view'
require_relative '../models/episode'

module Popmovies
  module Controllers
    class EpisodesController < Controller
      include Views
      include Models
      include Config

      CSS_SELECTOR = WEB[:episodes_css_selector]

      def initialize
        super
        @episode_view = EpisodeView.new
      end

      def render(season)
        @episodes =
          fetch_datas(season.url, CSS_SELECTOR) do |html_tags|
            episodes = html_tags.map do |episode|
              Episode.new(episode.css("span").text, episode['href'])
            end

            [Episode.new("Episode 1", season.url), episodes].flatten
          end

        @episode_view.populate_with(@episodes)
        @episode_view.render

        @router.trigger(:selected, @episode_view.selected)
      end

    end
  end
end
