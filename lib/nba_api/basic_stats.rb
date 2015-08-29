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

      def find(id, params = {})
        client.find(path_name, id, params)
      end

      def create(options)
        client.create(path_name, options)
      end

      def save(options)
        new(options).tap do |basic_data|
          yield basic_data if block_given?
        end.save
      end

      def parse(response)
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
