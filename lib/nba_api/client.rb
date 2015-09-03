require 'net/http'
require 'forwardable'
require 'active_support/inflector'

module NbaApi
  class Client
    extend Forwardable

    def initialize(attrs = {})
      @attributes = attrs
    end

    def get(api, params = {})
      uri = URI.parse(api)
      uri.query = URI.encode_www_form(params) unless params.empty?
      http_get(uri)
    end

    def find(path, params = {})
      nba_class = class_from_path(path)
      response = get(nba_class.api, params)
      nba_class.parse response
    end

    def create(path, options)
      nba_class = class_from_path(path)
      nba_class.save(options) { |data| data.client = self }
    end

    private

    def http_get(uri)
      http = Net::HTTP.new uri.host, uri.port
      request = Net::HTTP::Get.new uri.request_uri
      response = http.request request
      JSON.parse(response.body) rescue nil
    end

    def class_from_path(path_or_class)
      return path_or_class if path_or_class.is_a?(Class)
      NbaApi.const_get(path_or_class.to_s.singularize.camelize)
    end
  end
end
