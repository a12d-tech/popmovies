require "popmovies/version"
require "popmovies/application"

module Popmovies

  def self.start
    app = Application.new

    Kernel.at_exit{
      app.stop
    }

    Signal.trap('SIGINT') do
      app.stop
    end

    app.run
  end

end
