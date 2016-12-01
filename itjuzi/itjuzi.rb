require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'
require 'nokogiri'
require 'pry-rails'

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  open(api, 'User-Agent' => user_agent).read
end


API = 'https://www.itjuzi.com/investfirm'


def parse_list(page)
  api = "https://www.itjuzi.com/investevents?scope=12&page=#{page}"
  html = get(api)
  html_object = Nokogiri::HTML(html)
  items = html_object.css('ul.list-main-eventset').last.css('li')
  items.map do |item|
    date = item.css('.round').first.text.gsub("\t", '').gsub("\n", '')
    round = item.css('.round').last.text.gsub("\t", '').gsub("\n", '')
    name = item.css('.title').first.text.gsub("\t", '').gsub("\n", '')
    url = item.css('.title').first.css('a').attribute('href').text
    investors = item.css('.date').first.css('.investorset').first.css('a').map do |investor|
      {name: investor.text, url: investor.attribute('href').text}
    end
    investors += item.css('.date').first.css('.investorset').first.css('span.c-gray').map do |investor|
      {name: investor.text, url: ''}
    end
    amount = item.css('.fina').text.gsub("\t", '').gsub("\n", '')
    {name: name, date: date, round: round, url: url, investors: investors, amount: amount}.merge(parse_detail(url))
  end
end

def parse_detail(url)
  html = get(url)
  html_object = Nokogiri::HTML(html)
  container = html_object.css('.block')
  desc = container.children.css('div')[1].text.gsub("\t", '').gsub("\n", '')
  details = container.children.css('div').last.css('td')
  company_url = details[1].css('a').first.attribute('href').text
  percentage = details.last.css('.per').text.gsub("\t", '').gsub("\n", '')
  {desc: desc, company_url: company_url, percentage: percentage}
end


def run
  (1..131).each do |page|
    puts "page: #{page} start"
    result = parse_list(page)
    File.open("#{page}.json", "w") do |f|
      f.write(result.to_json)
    end
    puts "page: #{page} done"
    sleep(3)
  end
end

def merge
  result = []
  (1..131).each do |page|
    result += JSON.parse(File.read("#{page}.json"))
  end
  File.open("result.json", "w") do |f|
    f.write(result.to_json)
  end
end

def to_csv
  data = JSON.parse(File.read('result.json'))
  data.each do |d|
    investors = d.delete('investors')
    d['investors'] = investors.map {|i| i['name']}.join('，')
  end
  File.open("data.json", "w") do |f|
    f.write(data.to_json)
  end
end

to_csv