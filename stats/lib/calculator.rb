require 'json'
require 'csv'
require 'active_support/all'
FILTERS = {"TrackingStatsPerGame/Efficiency/MIN" => 10, "GP" => 20}


def add_percent_to_tracking(file_name)
  json_data = JSON.parse(File.read("result/#{file_name}.json"))
  json_data.each do |_, data|
    'FREQUENCY'
    temp = data['TrackingStats']['Efficiency']
    pts = temp['POINTS']
    temp.keys.each do |k|
      if k.include?('_PTS')
        freq = temp[k]/pts
        data['TrackingStats']['Efficiency'][k.gsub('_PTS', '_FREQUENCY')] = freq
      end
    end
  end
  File.open("result/#{file_name}.json", "w") do |f|
    f.write(json_data.to_json)
  end
end

def get_winners
  result = {}
  json_data = JSON.parse(File.read('result/gamelog.json'))
  json_data.each do |stats|
    if stats['WL'] == 'W'
      result[stats['GAME_ID']] = stats['TEAM_ID']
    end
  end
  File.open("result/winners.json", "w") do |f|
    f.write(result.to_json)
  end
end

def split_shots_by_game_result(file)
  json_data = JSON.parse(File.read("result/team_shots/#{file}_shots.json"))
  winners = JSON.parse(File.read('result/winners.json'))
  win_shots = []
  lose_shots = []
  json_data.each do |shot|
    if winners[shot['GAME_ID']] == shot['TEAM_ID']
      win_shots.push shot
    else
      lose_shots.push shot
    end
  end
  File.open("result/team_shots/#{file}_win_shots.json", "w") do |f|
    f.write(win_shots.to_json)
  end
  File.open("result/team_shots/#{file}_lose_shots.json", "w") do |f|
    f.write(lose_shots.to_json)
  end
end

def merge_categories(input_file_name, output_file_name)
  uniq_categories = ["PLAYER_ID", "PLAYER_NAME", "PLAYER_LAST_TEAM_ID", "PLAYER_LAST_TEAM_ABBREVIATION", 'TEAM_SHOT_NAME', 'PLAYER_NUMBER', 'P',
                     'TEAM_ID', 'TEAM_ABBREVIATION', "AGE", "GP", "W", "L", "CFID", "CFPARAMS", 'PLAYER_FIRST_NAME', 'PLAYER_LAST_NAME', 'SEASON', 'SEASON_TYPE']
  json_data = JSON.parse(File.read("result/#{input_file_name}.json"))
  result = Hash.new { |h, k| h[k] = {} }
  json_data.each do |id, data|
    data.each do |k, v|
      v.each do |kk, vv|
        vv.each do |kkk, vvv|
          key = uniq_categories.include?(kkk) ? kkk : [k, kk, kkk].join('/')
          result[id][key] = vvv
        end
      end
    end
  end
  File.open("result/#{output_file_name}.json", "w") do |f|
    f.write(result.to_json)
  end
end

def maxmin_values(data, keys)
  result = {}
  temp = Hash.new { |h, k| h[k] = [] }
  data.each do |_, stats|
    keys.each do |key|
      temp[key] << stats[key] if stats[key].present?
    end
  end
  temp.each { |key, values| result[key] = [values.min, values.max] }
  result
end

def valid_player?(stats)
  FILTERS.each do |key, value|
    return false if stats[key] < value
  end
  true
end


def normalize(input_file_name, output_file_name)
  json_data = JSON.parse(File.read("result/#{input_file_name}.json"))
  json_data = json_data.select { |_, stats| valid_player?(stats) }
  p json_data.size
  keys = json_data.first.last.keys.select { |key| key.include?('/') }
  maxmin_values = maxmin_values(json_data, keys)
  json_data.each do |_, stats|
    keys.each do |key|
      original_value = stats[key] || 0
      min_value, max_value = maxmin_values[key]
      stats[key] = (original_value - min_value).to_f.abs/(max_value - min_value)
    end
  end
  File.open("result/#{output_file_name}.json", "w") do |f|
    f.write(json_data.values.to_json)
  end
end

def merged_headers(input_file_name)
  json_data = JSON.parse(File.read("result/#{input_file_name}.json"))
  output_file_path = 'lib/merged_headers.json'
  File.open(output_file_path, "w") do |f|
    f.write(json_data.first.last.keys)
  end
end

send(*ARGV)