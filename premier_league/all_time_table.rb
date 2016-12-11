require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'
require 'nokogiri'

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  open(api, 'User-Agent' => user_agent).read
end

# "https://www.shanbay.com/wordlist/#{wordbook_id}/#{wordlist_id}/?page=#{page}"

def parse_wordbook(id)
  html = File.read('test2.html')
  html_object = Nokogiri::HTML(html)
  title = html_object.css('div.wordbook-title a').text
  wordlists = html_object.css('div .wordbook-create-candidate-wordlist.wordbook-containing-wordlist').map do |html_item|
    title = html_item.css('td.wordbook-wordlist-name a').first.name
    id = html_item.attributes['id'].value.split('-').last
    {title: html_item.css('td.wordbook-wordlist-name a').first.name, id: html_item.attributes['id'].value.split('-').last}
  end

end

def parse_wordlist(wordbook_id, wordlist_id, page)
  # html = File.read('test.html')
  api = "https://www.shanbay.com/wordlist/#{wordbook_id}/#{wordlist_id}/?page=#{page}"
  html = get(api)
  html_object = Nokogiri::HTML(html)
  items = html_object.css('tr.row')
  data = items.map do |item|
    {word: item.css('td.span2').text,  meaning: item.css('td.span10').text}
  end
  parent_title = html_object.css('p a').first.text
  title = html_object.css('h4').first.text.split("\n").first
  desc = html_object.css('div.wordlist-description-container').first.text
  data
end

wordbooks = [2725]
result = []
30.times do |i|
  words = parse_wordlist(2725, 27373, i+1)
  break if words.blank?
  result += words
  sleep(2)
end

File.open("27373.json", "w") do |f|
  f.write(result.to_json)
end