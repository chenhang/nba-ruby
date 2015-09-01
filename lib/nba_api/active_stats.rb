module NbaApi
  class ActiveStats < ActiveRestClient::Base
    base_url 'localhost'

    before_request :generate_params

    after_request do |name, response|
      to_hash(JSON.parse(response)) rescue ''
    end

    def current_season
      '2015-16'
    end

    def default_params
      {}
    end

    def generate_params name, request
      p self
      p super
      p 'next'
      request.get_params.update default_params[name] rescue self.default_params[name]
    end

    def to_hash origin
      result_sets = origin['resultSets']
      {}.tap do |data_sets|
        result_sets.each { |result_set| data_sets[result_set['name']] = parse_result_set result_set }
      end rescue {}
    end

    def parse_result_set result_set
      {}.tap do |data_set|
        result_set['headers'].each_with_index { |header, index| data_set[header] = result_set['rowSet'][index] }
      end
    end
  end
end
