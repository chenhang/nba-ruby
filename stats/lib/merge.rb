require 'json'
require 'active_support/all'

def merge(files, merged_file_name)
  result = Hash.new { |h, k| h[k] = Hash.new { |hh, kk| hh[kk] = {} } }

  files.each do |file|
    data = JSON.parse(File.read("result/#{file}.json"))
    puts file
    data.each do |k, v|
      v.each do |kk, vv|
        vv.each do |vvv|
          result[vvv['PLAYER_ID'].to_s][k][kk] = vvv
        end
      end
    end
  end

  File.open("result/#{merged_file_name}.json", "w") do |f|
    f.write(result.to_json)
  end
end


merged_file_name = ARGV.first
files = ARGV[1..-1]

merge(files, merged_file_name)