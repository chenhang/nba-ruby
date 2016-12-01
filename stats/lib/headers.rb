require 'json'
require 'active_support/all'

def headers
  json_data = JSON.parse(File.read('data/merged_league.json'))
  dd = json_data.first.last.map do |k, v|
    [k.to_s, v.map do |kk, vv|
      [kk.to_s, vv.keys]
    end.to_h]
  end.to_h
  File.open("headers.json", "w") do |f|
    f.write(dd.to_json)
  end
end

headers