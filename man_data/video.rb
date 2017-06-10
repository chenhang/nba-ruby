require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'
require 'nokogiri'

def get
  # user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36"
  open("https://www.reddit.com/r/reddevils/comments/6d8ovk/201617_manchester_united_matches_in_720p_hd/?st=J34DSS2V&sh=09ea6bce").read
end

def grab_video_urls
  h = Nokogiri::HTML(get)
  c = h.css('.expando')[0].children.css('.usertext-body')[0].children[0].css('p').map do |cc|
    href = cc.children.map {|ccc| ccc.attribute('href') }.compact.first.try :text
    name = cc.text
    next unless href.to_s.include? 'mega'
    {href: href, name: cc.text}
  end
  c.compact
end

def download_video
  d = JSON.parse(File.open('videos.json').read)
  
end

read_video_urls