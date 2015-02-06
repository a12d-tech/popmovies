require_relative "views/error_view"

module Popmovies

  class Error < StandardError
    include Views

    def initialize
      @error_message = "Oops something went wrong!"
    end

    def handle
      ErrorView.new(@error_message).render
      Kernel.exit
    end
  end

  class ConnectionError < Error
    def initialize
      @error_message = "Check your internet connection!"
    end
  end

  class RemoteError < Error
    def initialize
      @error_message = "It seems broken! Sorry"
    end
  end

end
