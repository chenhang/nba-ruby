require 'net/http'
require 'json'
require 'active_support/inflector'
class HashObject
  attr_accessor :id, :current_season
  def initialize(args={})
    self.id = args.fetch(:id, '')
    self.current_season = args.fetch(:current_season, '2014-15')
    save args.fetch(:data, {})
    self.id = self.send("#{self.class.name.downcase}_id").to_s if id.empty? && self.respond_to?("#{self.class.name.downcase}_id")
  end

  def save hash
    hash.each { |k, v| to_self k, detect(v) }
    self
  end

  def create data
    save to_hash(data)
  end

  def detect v
    if v.class == Array
      v.map { |item| detect item }
    else
      v.class == Hash ? self.class.new(data: v) : v
    end
  end

  def to_self k, v
    self.instance_variable_set("@#{k}", v)
    self.class.send(:define_method, k, proc { self.instance_variable_get("@#{k}") })
    self.class.send(:define_method, "#{k}=", proc { |v| self.instance_variable_set("@#{k}", v) })
  end

  def to_hash origin
    {}.tap do |data_sets|
      origin['resultSets'].each do |result_set|
        data_sets[result_set['name'].underscore] = parse_result_set result_set
      end
    end
  end

  def parse_result_set result_set
    [].tap do |data_set|
      result_set['rowSet'].each do |row|
        data_set.push({}.tap do |element|
                        result_set['headers'].each_with_index do |header, index|
                          header.gsub!('PERSON_ID', 'PLAYER_ID')
                          element[header.underscore] = row[index]
                        end
                      end)
      end
    end
  end
end

class BasicStats < HashObject
  # def path_name
  #   self.class.name.split("::").last.underscore
  # end

  def self.apis
    {}
  end

  def self.default_params
    {}
  end

  def all params = {}
    get(:all, params)
  end

  def find params = {}
    get(:find, params)
  end

  def get(type, params = {})
    nba_class = self.class
    response = http_get nba_class.apis[type], params.merge(default_params[type])
    create response
  end

  def http_get(api, params = {})
    uri = URI.parse(api)
    uri.query = URI.encode_www_form(params) unless params.empty?
    grab(uri)
  end

  def grab(uri)
    http = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Get.new uri.request_uri
    p uri
    response = http.request request
    JSON.parse(response.body)
  end

  def refresh!
    find(id)
  end
end

class Player < BasicStats
  BASE_URL = 'http://stats.nba.com/stats'
  FIND_PATH = '/playercareerstats'
  ALL_PATH = '/commonallplayers'

  def default_params

    {all: {IsOnlyCurrentSeason: 1, LeagueID: '00', Season: current_season},
     find: {LeagueID: '00', PerMode: 'Totals', PlayerID: id}}
  end

  def self.apis
    {find: BASE_URL+FIND_PATH, all: BASE_URL+ALL_PATH}
  end
end


player = Player.new(id: '201566')
p player.find
