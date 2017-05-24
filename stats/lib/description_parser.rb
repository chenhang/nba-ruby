require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'
require 'rb-readline'
require 'pry'
require 'nokogiri'

URL_BASE = 'http://stats.nba.com'
def get(url)
  puts url
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  open(url, 'User-Agent' => user_agent).read
end


def parse_desc(url)
  html_object = Nokogiri::HTML(get(url))
  html_object.css('.stat-glossary')[0].children[1].children.map do |d|
    d.text.gsub("\n", '').presence
  end.compact.each_slice(2).to_h rescue {}
end

def parse_categories
  html_object = Nokogiri::HTML(get('http://stats.nba.com/players/traditional/'))

  html_object.css('.dropdown__subcategory').map do |category_object|
    category_object.children[1].children.select {|d| d.text.presence}.map do |ob|
      [ob.children.attribute('href').value, {name: ob.text}]
    end
  end.flatten.each_slice(2).to_h
end

def get_all_desc
  result = parse_categories
  parse_categories.each do |key, _|
    url = URL_BASE + key
    next if url.include?('{{')
    result[key][:desc] = parse_desc(url)
  end

  save result
end

def save(data)
  File.open('descriptions.json', 'w') {|f| f.write data.to_json}
end

def reformat_all_desc
  data = JSON.parse File.open('descriptions.json').read
  player_keys = data.keys.select {|k| k.include?('players') && data[k]['desc'].presence }
  results = player_keys.map do |key|
    next unless dd.include?(key)
    note = ddd.include?(key) ? "For rating player's performance and efficiency" : "For clustering players and rating player's performance of certain play type"
    dddd = ["GP", "W", "L", "MIN", "MINS"]
    d = data[key]
    result = {name: d['name'], stats: d['desc'].map {|header, desc| [header, {description: desc, note: note}] unless dddd.include?(header)}.compact.to_h}.compact
    [key, result]
  end.compact.to_h
  File.open('player_descriptions.json', 'w') {|f| f.write results.to_json}
end
reformat_all_desc