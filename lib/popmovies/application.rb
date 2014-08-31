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

    def self.exit
      Kernel.abort
    end

      # videos_list_tmp = page.css("div.filmborder div.filmcontent div.filmicerik")
      # videos_list = videos_list_tmp.xpath("./p//iframe[contains(@src,'embed')]")

      # episodes_list_tmp = page.css("div.filmborder div.filmcontent div.keremiya_part")
      # episodes_list = episodes_list_tmp.xpath('./a')

      # seasons_list = page.css("div.filmborder div.filmcontent div.moviefilm div.movief a")
      # series_list = page.css("div.sidebarborder div.sidebar-right ul li.cat-item a")

  end
end