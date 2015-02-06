module Popmovies
  module Config
    WEB = {
      :endpoint =>
        "http://streaming-series.org/",
      :tv_shows_css_selector =>
        "div.sidebarborder div.sidebar-right ul li.cat-item a",
      :seasons_css_selector =>
        "div.filmborder div.filmcontent div.moviefilm div.movief a",
      :episodes_css_selector =>
        "div.filmborder div.filmcontent div.keremiya_part > a",
      :links_css_selector =>
        "div.filmborder div.filmcontent div.filmicerik"
    }
  end
end
