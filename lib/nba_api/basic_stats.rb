require 'active_support/inflector'

module NbaApi
  class BasicStats
    include ActiveModel::Validations
    include ActiveModel::Dirty
    include ActiveModel::Serializers::JSON

    class << self
      def path_name
        name.split("::").last.underscore
      end

      def find id, params = {}
        client.find(path_name, id, params)
      end

      def create options
        client.create(path_name, options)
      end

      def save options
        new(options).tap { |basic_stats| yield basic_stats if block_given? }.save
      end

      def parse response
        update_fields(to_hash response)
        yield self if block_given?
      end

      def to_hash origin
        result_sets = origin['resultSets']
        {}.tap do |data_sets|
          result_sets.each {|result_set| data_sets[result_set['name']] = parse_result_set result_set}
        end rescue {}
      end

      def parse_result_set result_set
        {}.tap do |data_set|
          result_set['headers'].each_with_index { |header, index| data_set[header] = result_set['rowSet'][index] }
        end
      end

      def update_fields fields
        fields.each { |field, value| self.instance_variable_set field.underscore, value }
      end
    end

    def self.api
      ''
    end

    def self.default_params
      {}
    end

    def self.client
      NbaApi.client
    end

    attr_writer :client

    def initialize
    end

    def refresh!
      self.class.find(id)
    end

    def client
      @client ||= self.class.client
    end
  end
end
