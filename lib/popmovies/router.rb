module Popmovies
  class Router

    def initialize
      @bindings = {}
    end

    def on(event, &block)
      @bindings.store(event, block)
    end

    def trigger(event, *args)
      @bindings.fetch(event).call(*args)
    end

  end
end
