class BasicStats < NbaApi::HashObject
  def path_name
    self.class.name.split("::").last.underscore
  end

  def find params = {}
    NbaApi::Client.find(path_name, params)
  end

  def to_hash origin
    result_sets = origin['resultSets']
    {}.tap do |data_sets|
      result_sets.each { |result_set| data_sets[result_set['name']] = parse_result_set result_set }
    end rescue {}
  end

  def create data
    self.save to_hash(data)
  end

  def parse_result_set result_set
    {}.tap do |data_set|
      result_set['headers'].each_with_index { |header, index| data_set[header] = result_set['rowSet'][index] }
    end
  end

  def self.apis
    {}
  end

  def self.default_params
    {}
  end

  def refresh!
    self.find(id)
  end
end
