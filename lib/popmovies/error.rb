require_relative "views/error_view"

module Popmovies

  class Error < StandardError
    include Views
    def handle
      ErrorView.new(self.message).show
      Kernel.abort
    end
  end

  class ConnectionError < Error; end
  class RemoteError < Error; end

end