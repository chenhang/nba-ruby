require 'json'
require 'csv'
require 'active_support/all'

module Enumerable

  def sum
    self.inject(0) { |accum, i| accum + i }
  end

  def mean
    self.empty? ? 0 : self.sum/self.length.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0) { |accum, i| accum +(i-m)**2 }
    sum/(self.length - 1).to_f
  end

  def standard_deviation
    return Math.sqrt(self.sample_variance)
  end

end

KEYS = ["OFF_RATING", "DEF_RATING", "AST_PCT", "AST_TO", "AST_RATIO", "OREB_PCT", "DREB_PCT", "REB_PCT", "TM_TOV_PCT", "EFG_PCT", "TS_PCT", "PACE", "PIE", "FTA_RATE", "OPP_EFG_PCT", "OPP_FTA_RATE", "OPP_TOV_PCT", "OPP_OREB_PCT", "PTS_OFF_TOV", "PTS_2ND_CHANCE", "PTS_FB", "PTS_PAINT", "OPP_PTS_OFF_TOV", "OPP_PTS_2ND_CHANCE", "OPP_PTS_FB", "OPP_PTS_PAINT", "PCT_FGA_2PT", "PCT_FGA_3PT", "PCT_PTS_2PT", "PCT_PTS_2PT_MR", "PCT_PTS_3PT", "PCT_PTS_FB", "PCT_PTS_FT", "PCT_PTS_OFF_TOV", "PCT_PTS_PAINT", "PCT_AST_2PM", "PCT_UAST_2PM", "PCT_AST_3PM", "PCT_UAST_3PM", "PCT_AST_FGM", "PCT_UAST_FGM"]

def adjust_value(v, max, min)
  (v - min).to_d / (max - min)
end

def get_extreme(data)
  {}.tap do |result|
    sums = Hash.new { |h, k| h[k] = [] }
    data.each do |_, values|
      values.slice(*KEYS).each { |key, value| sums[key] << value }
    end
    sums.each do |key, values|
      result[key] = {max: values.max, min: values.min}
    end
  end
end

def adjust_data(data)
  extreme_data = get_extreme(data)
  data.keys.each do |id|
    KEYS.each do |key|
      data[id][key] = adjust_value(data[id][key], extreme_data[key][:max], extreme_data[key][:min])
    end
  end
  data
end

def get_distance(a, b)
  distances_values = []
  KEYS.each do |key|
    distances_values << (a[key] - b[key]).abs
  end
  distances_values.sum.to_d / distances_values.size
end

def distances_data(data)
  {}.tap do |distances|
    adjust_data = adjust_data(data)
    adjust_data.each do |id, values|
      adjust_data.each { |_id, _values| distances[[id, _id].sort.join(',')] = get_distance(values, _values) }
    end
  end
end

def generate_distance_data(data)
  File.open("data/team_distances.json", "w") do |f|
    f.write(distances_data(data).to_json)
  end
end

def random_points(data, num = 5)
  rand_keys = []
  keys = data.keys
  size = data.keys.size
  num.times do |i|
    rand_index = rand(size)
    rand_keys << keys[rand_index]
    keys.delete_at rand_index
    size -= 1
  end
  rand_keys
end

def get_groups(data, distances, points)
  result = Hash.new { |h, k| h[k] = [] }
  data.keys.each do |key|
    min_distance = 1000000
    closest_point = ''
    points.each do |point|
      distance = distances[[point, key].sort.join(',')].to_f
      if distance < min_distance
        closest_point = point
        min_distance = distance
      end
    end
    result[closest_point] << key
  end
  actual_results = {}
  result.values.each do |ids|
    min_distance = 1000000
    closest_point = ''
    ids.each do |id|
      distance = ids.map { |other_id| distances[[id, other_id].sort.join(',')].to_f }.sum/ids.size
      closest_point, min_distance = id, distance if distance < min_distance
    end
    actual_results[closest_point] = ids
  end
  actual_results
end

def measure(result, distances)
  result.map do |_, values|
    values.map do |id|
      values.map { |_id| distances[[id, _id].sort.join(',')].to_f if id != _id }.compact.mean
    end.mean
  end.mean
end

def kmeans(data, distances, init_points_num=10)
  init_points = random_points(data, init_points_num).sort
  result = get_groups(data, distances, init_points)
  while true
    old_keys = result.keys.sort
    result = get_groups(data, distances, old_keys)
    break if result.keys.sort == old_keys
  end

  [result, measure(result, distances)]
end

def calculate(data, distances)
  final, min = nil, 10000
  50.times do
    result, measurement = kmeans(data, distances, 6)
    final, min = result, measurement if measurement < min
  end
  p min
  final
end

data = JSON.parse(File.read('data/teams_stats.json'))

distances = distances_data(data) #JSON.parse(File.read('data/team_distances.json'))

p calculate(data, distances).values
