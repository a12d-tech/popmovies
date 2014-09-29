require_relative 'ui/template'
require_relative 'router'

module Popmovies
  class Application
    include Controllers
    include Ui

    def initialize
      @tmpl = Template.new
      @router = Router.new
    end

    def run
      @router.get :home
    end

    def stop
      @tmpl.close
    end

  end
end