require 'json'
require 'csv'

json_data = JSON.parse(File.read('us.json'))
csv_data = CSV.parse(File.read('state.csv'), :headers => true)
csv_array = csv_data.map do |row|
  [row['state'], row['conference']]
end.to_h

p csv_array
json_data['objects']['states']['geometries'].each do |item|
  item['properties']['conference'] = csv_array[item['properties']['name']]
end

File.open("parsed_stats.json", "w") do |f|
  f.write(json_data.to_json)
end