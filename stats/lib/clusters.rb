require 'json'
require 'csv'
require 'active_support/all'

PLAYTYPE_KEYS = %w(Transition Isolation PRBallHandler PRRollman Postup Spotup Handoff Cut OffScreen OffRebound)


FILTERS = {"GeneralStatsTotals/Base/MIN" => 15, "GP" => 30}

def distance_key(id, _id)
  [id, _id].sort.join(',')
end

def selected_keys
  play_type_keys
end

def freq_keys
  data.first.last.keys.select { |key| key.include?('FREQUENCY') && key.include?('Efficiency') } +
      ["GeneralRange/Totals/FG3A_FREQUENCY"]
end

def play_type_keys
  init_key = 'PlayTypesTotals/{KEY}/Time'
  PLAYTYPE_KEYS.map do |key|
    init_key.gsub('{KEY}', key)
  end
end

def maxmin_values(data)
  result = {}
  temp = Hash.new { |h, k| h[k] = [] }
  keys = selected_keys
  data.each do |_, stats|
    keys.each do |key|
      temp[key] << (stats[key] || 0)
    end
  end
  temp.each do |key, values|
    result[key] = {max: values.max, min: values.min, uniq: values.map { |v| v.round(2) }.uniq.sort}
  end
  result
end

def distances(data)
  result = {}
  maxmin_values = maxmin_values(data)
  selected_keys = selected_keys
  data.each do |id, stats|
    data.each do |_id, _stats|
      if id != _id
        result[distance_key(id, _id)] = distance_between(stats, _stats, selected_keys, maxmin_values)
      end
    end
  end
  result
end

def distance_between(stats, _stats, selected_keys, maxmin_values)
  distances = []
  selected_keys.each do |key|
    max, min = maxmin_values[key].values
    a, b = (stats[key] || 0), (_stats[key] || 0)
    distances << calculate_distance(a, b, max, min)
  end
  distances.sum / distances.size
end

def calculate_distance(a, b, max, min)
  a = (a - min).to_d/(max - min)
  b = (b - min).to_d/(max - min)
  (a - b).abs
end

def valid_player?(stats)
  FILTERS.each do |key, value|
    if stats[key] < value
      return false
    end
  end
  stats.slice(*play_type_keys())
  true
end

def random_points(points, num)
  rand_points = []
  size = points.size
  num.times do |i|
    rand_index = rand(size)
    rand_points << points[rand_index]
    points.delete_at rand_index
    size -= 1
  end
  rand_points
end

def similar_players(data, distances)
  ids = data.keys
  results = ids.map do |id|
    similar_players = {id => 0}
    ids.each do |_id|
      distance = distances[distance_key(id, _id)].try(:to_d) || 0
      similar_players[_id] = distance
    end
    similar_players.sort_by { |_, v| v }.first(30).map { |a| a.first }.sort
  end
  results.sort.uniq
end

def store_distance(data)
  File.open("../result/distances.json", "w") do |f|
    f.write(distances(data).to_json)
  end
end

def store_similar_players(data, distances)
  File.open("../result/similar_players.json", "w") do |f|
    f.write(similar_players(data, distances).to_json)
  end
end

def group_distances(data, similar_players)
  results = similar_players.map do |ids|
    result = {ids => 0}
    similar_players.each do |_ids|
      distance = (ids.size - (ids & _ids).uniq.size).to_f/ids.size
      result[ids] = distance
    end
    result.sort_by { |_, v| v }.first(2).map { |a| a.first }.sort.inject(&:&).flatten.uniq.sort
  end
  results = results.sort.uniq
  results.map do |ids|
    results.each do |_ids|

    end
  end
end

data = JSON.parse(File.read('../result/dashboard/2015-16/2015-16_dashboard.json'))
data = data.select { |_, stats| valid_player?(stats) }
distances = JSON.parse(File.read('../result/distances.json'))
similar_players = JSON.parse(File.read('../result/similar_players.json'))
group_distances = group_distances(data, similar_players)
p group_distances, group_distances.size