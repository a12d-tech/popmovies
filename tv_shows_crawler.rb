#!/usr/bin/env ruby
# author : gntics gntics@gmail.com
# version: v0.9.0 beta

require 'nokogiri'
require 'open-uri'

WEBSITE_URL = "http://streaming-series.org/"
MENU_SERIES_HASH = Hash.new
MENU_SEASONS_HASH = Hash.new
MENU_EPISODES_HASH = Hash.new

def hello_msg
  puts "############################################"
  puts "##         Hey what's up buddy?           ##"
  puts "##        Need to watch smthing?          ##"
  puts "############################################"
end

def msg text, deco=false
  puts "-"
  if !deco
    puts "- #{text}"
  else
    puts "----->  #{text}  <-----"
    puts "-"
  end
end

def check_choice hash
  msg "What do you want to see ? (number|b=back|q=quit)"
  answer = gets
  if answer.chomp === "q"
    Kernel.abort("##     Hope to see you soon, see ya bitch ;)     ##")
  elsif answer.chomp === "b"
    msg "Okay, let's go back for now!"
    return -1
  else
    msg "Come on! Booooring, you choose: #{hash[answer.chomp.to_i].split('-||-')[0]}"
    return hash[answer.chomp.to_i]
  end
end

def print_menu hash, type
  msg "#{hash.length} #{type} found", true
  hash.each_pair do |key,value|
    puts "#{key} \t# #{value.split('-||-')[0]}"
  end
end

def fetch_html_page url
  page = Nokogiri::HTML(open(url)) do |config|
    config.nonet
  end
  return page
end

def step5_enjoy
  puts "-"
  Kernel.abort("##     Enjoy your watching     ##")
end

def step4_fetch_video_links episode_infos
  episode_page_url = episode_infos.split('-||-')[1]
  page = fetch_html_page episode_page_url

  videos_list_tmp = page.css("div.filmborder div.filmcontent div.filmicerik")
  videos_list = videos_list_tmp.xpath("./p//iframe[contains(@src,'embed')]")

  msg "#{videos_list.length} link(s) found", true
  videos_list.each do |video_link|
    puts "- #{video_link['src']}"
  end

  step5_enjoy
end

def step3_fetch_episodes_menu season_infos
  MENU_EPISODES_HASH.clear

  episodes_menu_url = season_infos.split('-||-')[1]

  page = fetch_html_page episodes_menu_url

  episodes_list_tmp = page.css("div.filmborder div.filmcontent div.keremiya_part")
  episodes_list = episodes_list_tmp.xpath('./a')

  MENU_EPISODES_HASH[1] = "Episode 1-||-#{episodes_menu_url}"
  episodes_list.each_with_index do |episode,index|
    episode_title = episode.css("span").text
    episode_title_link = episode['href']
    MENU_EPISODES_HASH[index+2] = "#{episode_title}-||-#{episode_title_link}"
  end

  print_menu MENU_EPISODES_HASH, "episodes"
  choice = check_choice MENU_EPISODES_HASH
  if choice == -1
    step2_fetch_seasons_menu nil, true
  elsif
    step4_fetch_video_links choice
  end
end

def step2_fetch_seasons_menu serie_infos, forward=false
  if !forward
    MENU_SEASONS_HASH.clear

    seasons_menu_url = serie_infos.split('-||-')[1]

    page = fetch_html_page seasons_menu_url

    seasons_list = page.css("div.filmborder div.filmcontent div.moviefilm div.movief a")

    seasons_list.each_with_index do |season,index|
      season_title = season.text
      season_title_link = season['href']
      MENU_SEASONS_HASH[index+1] = "#{season_title}-||-#{season_title_link}"
    end
  end

  print_menu MENU_SEASONS_HASH, "seasons"
  choice = check_choice MENU_SEASONS_HASH
  if choice == -1
    step1_fetch_series_menu true
  else
    step3_fetch_episodes_menu choice
  end
end

def step1_fetch_series_menu forward=false
  if !forward
    page = fetch_html_page WEBSITE_URL

    series_list = page.css("div.sidebarborder div.sidebar-right ul li.cat-item a")

    series_list.each_with_index do |serie,index|
      serie_title = serie.text
      serie_title_link = serie['href']
      MENU_SERIES_HASH[index+1] = "#{serie_title}-||-#{serie_title_link}"
    end
  end
  print_menu MENU_SERIES_HASH, "tv shows"
  choice = check_choice MENU_SERIES_HASH
  if choice == -1
    step1_fetch_series_menu true
  else
    step2_fetch_seasons_menu choice
  end
end

def start_process
  hello_msg
  step1_fetch_series_menu
end

#start main process
start_process

