module NbaApi
  class HashObject
    def initialize(hash={})
      save hash unless hash.nil?
    end

    def save hash
      hash.each { |k, v| to_self k, detect(v) }
      self
    end

    def detect v
      if v.class == Array
        v.map { |item| detect item }
      else
        v.class == Hash ? HashObject.new v : v
      end
    end

    def to_self k, v
      self.instance_variable_set("@#{k}", v)
      self.class.send(:define_method, k, proc { self.instance_variable_get("@#{k}") })
      self.class.send(:define_method, "#{k}=", proc { |v| self.instance_variable_set("@#{k}", v) })
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