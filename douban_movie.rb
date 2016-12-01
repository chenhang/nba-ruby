require 'nokogiri'
require 'json'
require 'csv'
require 'active_support/all'
require 'open-uri'

TEST_URL = "https://movie.douban.com/people/monstericing/collect?start=180&sort=time&rating=all&filter=all&mode=grid"
TEST_MOVIE = 'https://movie.douban.com/subject/3564499/'
RATING_XPATH = '/div[2]/ul/li[3]/span[1]'

def get(url)
  puts "get: #{url}"
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36"
  open(url, 'User-Agent' => user_agent).read
end

def api(username, page = 0)
  index = page * 15
  "https://movie.douban.com/people/#{username}/collect?start=#{index}&sort=time&rating=all&filter=all&mode=grid"
end

def rating(item)
  puts "rating"
  item.css('span').map do |div|
    (div.attributes['class'].value.split('') & ['1', '2', '3', '4', '5']).first unless div.attributes['class'].value.nil?
  end.compact.first
end

def movie_api(item)
  puts "movie_url"
  item.css('a').last.attributes['href'].value.gsub('https://movie.douban.com/subject/', 'https://api.douban.com/v2/movie/')[0..-2]
end

def tags(item)
  movie_data = JSON.parse(get(movie_api(item)))
  sleep(1)
  authors = movie_data['author'].to_a.map { |author| author['name'] }

  cast = movie_data['attrs']['cast'].to_a + movie_data['attrs']['writer'].to_a + movie_data['attrs']['director'].to_a
  tags = movie_data['tags'].map { |tag| tag['name'] }
  (authors + cast + tags).compact.uniq << movie_data['rating']['average']
end

def tags_by_id(movie_id)
  movie_data = JSON.parse(get('https://api.douban.com/v2/movie/'+movie_id))
  sleep(1)
  authors = movie_data['author'].to_a.map { |author| author['name'] }

  cast = movie_data['attrs']['cast'].to_a + movie_data['attrs']['writer'].to_a + movie_data['attrs']['director'].to_a
  tags = movie_data['tags'].map { |tag| tag['name'] }
  (authors + cast + tags).compact.uniq << movie_data['rating']['average']
end

def get_data_set(username)
  result = []
  page = 0
  while true
    if File.exist?("movie_data/#{username}/#{page}.json")
      puts 'pass'
      page += 1
      next
    end
    items_html = Nokogiri::HTML(get(api(username, page))).css('div.item')
    break if items_html.size <= 0
    items = items_html.map { |item| tags(item) << rating(item) }
    puts items

    File.open("movie_data/#{username}/#{page}.json", "w") do |f|
      f.write(items.to_json)
    end
    result += items
    sleep(3)
    page += 1
  end
  result
end

def scrapy
  File.open("robbb.json", "w") do |f|
    f.write(get_data_set('robbb').to_json)
  end
end


def tag_values(username, avg_rating)
  tags = Hash.new { |h, k| h[k] = [0, 0] }
  Dir["movie_data/#{username}/*"].each do |filename|
    data = JSON.parse(File.read(filename))
    data.each do |item|
      points = item[-1].to_i - avg_rating
      item[0..-3].each do |tag|
        tags[tag][0] += points.to_f
        tags[tag][1] += 1
      end
    end
  end
  # tags.map { |tag, (total, size)| [tag, [total, size]] }.to_h.sort_by { |_, v| v.first * v.last }.to_h
  # tags.map { |tag, (total, size)| [tag, [total, size]] }.to_h.sort_by { |_, v| v.first }.to_h
  tags.map { |tag, (total, size)| [tag, total.to_f/size] }.sort_by { |_, v| v }.to_h
end

def rating2comment(rating)
  [1, 1, 2, 3, 3][rating-1]
end

def avg_rating(username)
  size = 0
  sum = 0
  Dir["movie_data/#{username}/*"].each do |filename|
    data = JSON.parse(File.read(filename))
    sum += data.map { |item| item[-1].to_i }.sum.to_f
    size += data.size
  end
  sum / size
end

def parse(username)
  avg_rating = avg_rating(username)
  tag_values = tag_values(username, avg_rating)
  result = []
  Dir["movie_data/#{username}/*"].each do |filename|
    data = JSON.parse(File.read(filename))
    data.each do |item|
      rating = item[-1].to_i
      tags = item[0..-3].map { |tag| tag_values[tag] }.compact.uniq
      tags_value = tags.sum.to_f/tags.size
      result << [tags_value, rating2comment(rating)]
    end
  end
  result
end

username = 'monstericing'

# result = parse(username)
# File.open("#{username}.txt", "w") do |f|
#   result.each do |(value, comment)|
#     f.write("#{value.round(3)}\t#{comment}\n")
#   end
# end

tags = tags_by_id('25879091')
def calculate_rating(tags, username)
  avg_rating = avg_rating(username)
  tag_values = tag_values(username, avg_rating)
  results = tags.map {|tag| tag_values[tag] }.compact
  results.sum.to_f/results.size# + avg_rating
end
p calculate_rating(tags, username)

avg_rating = avg_rating(username)
tag_values = tag_values(username, avg_rating)
# p tag_values
