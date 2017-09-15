require 'active_support/all'
dashboard_file = 'general_dashboard'
shot_dashboard_file = 'shot_dashboard'
defense_dashboard_file = 'defense_dashboard'
play_types_file = 'play_types_dashboard'

files = [shot_dashboard_file, dashboard_file, play_types_file, defense_dashboard_file]
puts 'start!!!'
puts `mkdir result`
puts `mkdir result/dashboard`


(2015..2016).each do |year|
  season = "#{year}-#{(year+1).to_s.last(2)}"
  puts season
  puts `mkdir result/dashboard/#{season}`

  temp_name = "dashboard/#{season}/_#{season}_dashboard"
  final_name = "dashboard/#{season}/#{season}_dashboard"
  `mkdir result/dashboard/#{season}`
  puts 'start get play types data'
  system("ruby lib/play_type_parser.rb download_for #{season}", out: $stdout, err: :out)
  puts 'finished get play types data'

  # puts 'start get general dashboard data'
  # system("ruby lib/dashboard_parser.rb download_for #{season}", out: $stdout, err: :out)
  # puts 'finished get general dashboard data'

  # puts 'start get shot dashboard data'
  # system("ruby lib/shot_dashboard_parser.rb download_for #{season}", out: $stdout, err: :out)
  # puts 'finished get shot dashboard data'

  # puts 'start get defense dashboard data'
  # system("ruby lib/defense_dashboard_parser.rb download_for #{season}", out: $stdout, err: :out)
  # puts 'finished get defense dashboard data'

  file_names = files.map { |name| "dashboard/#{season}/#{season}_#{name}" }.join(' ')
  puts 'start merge data sets'
  puts `ruby lib/merge.rb #{temp_name} #{file_names}`
  puts 'finished merge data sets'

  puts 'start merge categories and export for csv'
  puts `ruby lib/calculator.rb merge_categories #{temp_name} #{final_name}`
  puts `ruby lib/calculator.rb merged_headers #{final_name}`
  puts 'finished merge categories'

  sleep(5)
end
puts 'done'

