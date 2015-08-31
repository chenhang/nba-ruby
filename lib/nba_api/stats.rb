class Stats < ActiveRestClient::Base
  base_url 'localhost'

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