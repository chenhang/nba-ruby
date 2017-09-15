require 'json'
require 'csv'
require 'active_support/all'
TEAMS = {
    'ATL': {
        'abbr': 'ATL',
        'city': 'Atlanta',
        'code': 'hawks',
        'conference': 'Eastern',
        'displayAbbr': 'ATL',
        'displayConference': 'Eastern',
        'division': 'Southeast',
        'id': '1610612737',
        'name': 'Hawks',
        'color': 'E2373E',
        'colors': ['E2373E', '002A5C', 'BAC4CA']
    }, 'BOS': {
        'abbr': 'BOS',
        'city': 'Boston',
        'code': 'celtics',
        'conference': 'Eastern',
        'displayAbbr': 'BOS',
        'displayConference': 'Eastern',
        'division': 'Atlantic',
        'id': '1610612738',
        'name': 'Celtics',
        'color': '007239',
        'colors': ['007239', 'AE8445', '982527', '000000']
    }, 'BKN': {
        'abbr': 'BKN',
        'city': 'Brooklyn',
        'code': 'nets',
        'conference': 'Eastern',
        'displayAbbr': 'BKN',
        'displayConference': 'Eastern',
        'division': 'Atlantic',
        'id': '1610612751',
        'name': 'Nets',
        'color': '000000',
        'colors': ['000000', 'FFFFFF']
    }, 'CHA': {
        'abbr': 'CHA',
        'city': 'Charlotte',
        'code': 'hornets',
        'conference': 'Eastern',
        'displayAbbr': 'CHA',
        'displayConference': 'Eastern',
        'division': 'Southeast',
        'id': '1610612766',
        'name': 'Hornets',
        'color': '00848E',
        'colors': ['00848E', '260F54', 'CCCCCC']
    }, 'CHI': {
        'abbr': 'CHI',
        'city': 'Chicago',
        'code': 'bulls',
        'conference': 'Eastern',
        'displayAbbr': 'CHI',
        'displayConference': 'Eastern',
        'division': 'Central',
        'id': '1610612741',
        'name': 'Bulls',
        'color': 'C60033',
        'colors': ['C60033', '000000']
    }, 'CHO': {
        'abbr': 'CHO',
        'city': 'Charlotte',
        'code': 'hornets',
        'conference': 'Eastern',
        'displayAbbr': 'CHA',
        'displayConference': 'Eastern',
        'division': 'Southeast',
        'id': '1610612766',
        'name': 'Hornets',
        'color': '00848E',
        'colors': ['00848E', '260F54', 'CCCCCC']
    }, 'CLE': {
        'abbr': 'CLE',
        'city': 'Cleveland',
        'code': 'cavaliers',
        'conference': 'Eastern',
        'displayAbbr': 'CLE',
        'displayConference': 'Eastern',
        'division': 'Central',
        'id': '1610612739',
        'name': 'Cavaliers',
        'color': '860038',
        'colors': ['860038', '002D62', 'FDBA31']
    }, 'DAL': {
        'abbr': 'DAL',
        'city': 'Dallas',
        'code': 'mavericks',
        'conference': 'Western',
        'displayAbbr': 'DAL',
        'displayConference': 'Western',
        'division': 'Southwest',
        'id': '1610612742',
        'name': 'Mavericks',
        'color': '0063AF',
        'colors': ['0063AF', 'BAC4CA', '000000']
    }, 'DEN': {
        'abbr': 'DEN',
        'city': 'Denver',
        'code': 'nuggets',
        'conference': 'Western',
        'displayAbbr': 'DEN',
        'displayConference': 'Western',
        'division': 'Northwest',
        'id': '1610612743',
        'name': 'Nuggets',
        'color': '559FD6',
        'colors': ['559FD6', '006BB7', 'FEA927']
    }, 'DET': {
        'abbr': 'DET',
        'city': 'Detroit',
        'code': 'pistons',
        'conference': 'Eastern',
        'displayAbbr': 'DET',
        'displayConference': 'Eastern',
        'division': 'Central',
        'id': '1610612765',
        'name': 'Pistons',
        'color': 'EC003D',
        'colors': ['EC003D', '0058A6', '001D4A']
    }, 'GSW': {
        'abbr': 'GSW',
        'city': 'Golden State',
        'code': 'warriors',
        'conference': 'Western',
        'displayAbbr': 'GSW',
        'displayConference': 'Western',
        'division': 'Pacific',
        'id': '1610612744',
        'name': 'Warriors',
        'color': '0068B3',
        'colors': ['0068B3', 'FFC423']
    }, 'HOU': {
        'abbr': 'HOU',
        'city': 'Houston',
        'code': 'rockets',
        'conference': 'Western',
        'displayAbbr': 'HOU',
        'displayConference': 'Western',
        'division': 'Southwest',
        'id': '1610612745',
        'name': 'Rockets',
        'color': 'C60033',
        'colors': ['C60033', '000000']
    }, 'IND': {
        'abbr': 'IND',
        'city': 'Indiana',
        'code': 'pacers',
        'conference': 'Eastern',
        'displayAbbr': 'IND',
        'displayConference': 'Eastern',
        'division': 'Central',
        'id': '1610612754',
        'name': 'Pacers',
        'color': '001D4A',
        'colors': ['001D4A', 'FEAC2D', 'B0B2B5']
    }, 'LAC': {
        'abbr': 'LAC',
        'city': 'Los Angeles',
        'code': 'clippers',
        'conference': 'Western',
        'displayAbbr': 'LAC',
        'displayConference': 'Western',
        'division': 'Pacific',
        'id': '1610612746',
        'name': 'Clippers',
        'color': '00559A',
        'colors': ['00559A', 'EC003D']
    }, 'LAL': {
        'abbr': 'LAL',
        'city': 'Los Angeles',
        'code': 'lakers',
        'conference': 'Western',
        'displayAbbr': 'LAL',
        'displayConference': 'Western',
        'division': 'Pacific',
        'id': '1610612747',
        'name': 'Lakers',
        'color': 'FEA927',
        'colors': ['FEA927', '42186E', '000000']
    }, 'MEM': {
        'abbr': 'MEM',
        'city': 'Memphis',
        'code': 'grizzlies',
        'conference': 'Western',
        'displayAbbr': 'MEM',
        'displayConference': 'Western',
        'division': 'Southwest',
        'id': '1610612763',
        'name': 'Grizzlies',
        'color': '182A48',
        'colors': ['182A48', '4C78AD', 'FEA927', 'AAC8E5']
    }, 'MIA': {
        'abbr': 'MIA',
        'city': 'Miami',
        'code': 'heat',
        'conference': 'Eastern',
        'displayAbbr': 'MIA',
        'displayConference': 'Eastern',
        'division': 'Southeast',
        'id': '1610612748',
        'name': 'Heat',
        'color': '98002E',
        'colors': ['98002E', 'F88D1D', '000000']
    }, 'MIL': {
        'abbr': 'MIL',
        'city': 'Milwaukee',
        'code': 'bucks',
        'conference': 'Eastern',
        'displayAbbr': 'MIL',
        'displayConference': 'Eastern',
        'division': 'Central',
        'id': '1610612749',
        'name': 'Bucks',
        'color': 'C41230',
        'colors': ['C41230', '003815', 'BAC4CA']
    }, 'MIN': {
        'abbr': 'MIN',
        'city': 'Minnesota',
        'code': 'timberwolves',
        'conference': 'Western',
        'displayAbbr': 'MIN',
        'displayConference': 'Western',
        'division': 'Northwest',
        'id': '1610612750',
        'name': 'Timberwolves',
        'color': '#003F70',
        'colors': ['003F70', '006F42', 'BAC4CA', 'FFE211', 'DE2032', '000000']
    }, 'NOP': {
        'abbr': 'NOP',
        'city': 'New Orleans',
        'code': 'pelicans',
        'conference': 'Western',
        'displayAbbr': 'NOP',
        'displayConference': 'Western',
        'division': 'Southwest',
        'id': '1610612740',
        'name': 'Pelicans',
        'color': '#002B5C',
        'colors': ['002B5C', 'B4975A', 'E13A3E']
    }, 'NYK': {
        'abbr': 'NYK',
        'city': 'New York',
        'code': 'knicks',
        'conference': 'Eastern',
        'displayAbbr': 'NYK',
        'displayConference': 'Eastern',
        'division': 'Atlantic',
        'id': '1610612752',
        'name': 'Knicks',
        'color': 'F3571F',
        'colors': ['F3571F', '0067B2', 'BAC4CA']
    }, 'OKC': {
        'abbr': 'OKC',
        'city': 'Oklahoma City',
        'code': 'thunder',
        'conference': 'Western',
        'displayAbbr': 'OKC',
        'displayConference': 'Western',
        'division': 'Northwest',
        'id': '1610612760',
        'name': 'Thunder',
        'color': 'FDBB30',
        'colors': ['FDBB30', 'F05133', '007DC3', '002D62']
    }, 'ORL': {
        'abbr': 'ORL',
        'city': 'Orlando',
        'code': 'magic',
        'conference': 'Eastern',
        'displayAbbr': 'ORL',
        'displayConference': 'Eastern',
        'division': 'Southeast',
        'id': '1610612753',
        'name': 'Magic',
        'color': '006BB7',
        'colors': ['006BB7', 'BAC4CA', '000000']
    }, 'PHI': {
        'abbr': 'PHI',
        'city': 'Philadelphia',
        'code': 'sixers',
        'conference': 'Eastern',
        'displayAbbr': 'PHI',
        'displayConference': 'Eastern',
        'division': 'Atlantic',
        'id': '1610612755',
        'name': 'Sixers',
        'color': 'EC003D',
        'colors': ['EC003D', '00559A', 'BAC4CA']
    }, 'PHX': {
        'abbr': 'PHX',
        'city': 'Phoenix',
        'code': 'suns',
        'conference': 'Western',
        'displayAbbr': 'PHX',
        'displayConference': 'Western',
        'division': 'Pacific',
        'id': '1610612756',
        'name': 'Suns',
        'color': 'E45F1F',
        'colors': ['E45F1F', 'F89F1B', 'BAC4CA', '000000']
    }, 'POR': {
        'abbr': 'POR',
        'city': 'Portland',
        'code': 'blazers',
        'conference': 'Western',
        'displayAbbr': 'POR',
        'displayConference': 'Western',
        'division': 'Northwest',
        'id': '1610612757',
        'name': 'Trail Blazers',
        'color': 'DE2032',
        'colors': ['DE2032', 'BAC4CA', '000000']
    }, 'SAC': {
        'abbr': 'SAC',
        'city': 'Sacramento',
        'code': 'kings',
        'conference': 'Western',
        'displayAbbr': 'SAC',
        'displayConference': 'Western',
        'division': 'Pacific',
        'id': '1610612758',
        'name': 'Kings',
        'color': '542E91',
        'colors': ['542E91', 'BAC4CA', '000000']
    }, 'SAS': {
        'abbr': 'SAS',
        'city': 'San Antonio',
        'code': 'spurs',
        'conference': 'Western',
        'displayAbbr': 'SAS',
        'displayConference': 'Western',
        'division': 'Southwest',
        'id': '1610612759',
        'name': 'Spurs',
        'color': '#BA24CA',
        'colors': ['BA24CA', '000000']
    }, 'TOR': {
        'abbr': 'TOR',
        'city': 'Toronto',
        'code': 'raptors',
        'conference': 'Eastern',
        'displayAbbr': 'TOR',
        'displayConference': 'Eastern',
        'division': 'Atlantic',
        'id': '1610612761',
        'name': 'Raptors',
        'color': 'C60033',
        'colors': ['C60033', 'BAC4CA']
    }, 'UTA': {
        'abbr': 'UTA',
        'city': 'Utah',
        'code': 'jazz',
        'conference': 'Western',
        'displayAbbr': 'UTA',
        'displayConference': 'Western',
        'division': 'Northwest',
        'id': '1610612762',
        'name': 'Jazz',
        'color': '#002A5C',
        'colors': ['002A5C', '004812', 'FCB034', 'BACA4CA']
    }, 'WAS': {
        'abbr': 'WAS',
        'city': 'Washington',
        'code': 'wizards',
        'conference': 'Eastern',
        'displayAbbr': 'WAS',
        'displayConference': 'Eastern',
        'division': 'Southeast',
        'id': '1610612764',
        'name': 'Wizards',
        'color': '002A5B',
        'colors': ['002A5B', 'E21836', 'BAC4CA']
    }
}.with_indifferent_access
def normalise_by_count(data)
  types = data.values[0].keys
  ranges = types.map do |type|
    ranges = data.values.map { |d| d[type] }.sort
    [type, [ranges.first, ranges.last]]
  end.to_h
  data.keys.each do |key|
    types.each do |type|
      data[key][type] = (data[key][type] - ranges[type].first).to_f / (ranges[type].last - ranges[type].first)
    end
  end
  p ranges
  data
end

def parse_ncaa_csv
  data = []
  types = ["Post-Up", "P&R Ball Handler", "Isolation", "Transition", "Offscreen", "Handoff", "Spot-Up", "P&R Roll Man", "Cut", "Putbacks"]
  # cn_types = ["背身", "挡拆持球", "面框单打", "转换进攻", "绕掩护", "手递手", "定点突投", "挡拆接球", "空切", "二次进攻"]
  cn_types = ["背打", "挡拆持球", "单打", "快攻", "空手掩护", "手递手", "接球突/投", "挡拆接球", "空切", "补篮"]
  rows = CSV.read('../data/ncaa_play_types.csv', encoding: 'ISO-8859-1')
  headers = nil
  ac_types = []
  rows.each do |row|
    player = {}
    if !headers
      headers = row
    else
      headers.each_with_index do |header, i|
        player[header] = row[i]
      end
      type = player['Play Type'].force_encoding('GBK').encode('utf-8')
      ac_types << player['Play Type'].force_encoding('GBK').encode('utf-8')
      index = cn_types.index(type)
      player['Play Type'] = types[index] if index
      player['Season'] = '2016-17'
      player['Poss'] = player["Poss / Game"].to_f * player["GP"].to_i
    end
    data << player if player.any?
  end
  players = Hash.new { |h, k| h[k] = {} }
  data.each do |player|
    id = [player['Player'], 1, player['Team'], 0, player['Season']].join('_')
    if players[id][player['Play Type']].present?
      # p player
      # p result[id][player['Play Type']]
      if players[id][player['Play Type']]['GP'].to_i < player['GP'].to_i
        players[id][player['Play Type']] = player
      end
    else
      players[id][player['Play Type']] = player
    end
  end
  players
end

def parse_csv
  data = []
  CSV.open('../data/play_types.csv', 'r') do |rows|
    headers = nil
    rows.each do |row|
      player = {}
      if !headers
        headers = row
      else
        headers.each_with_index do |header, i|
          player[header] = row[i]
        end
      end
      data << player if player.any?
    end
  end
  # types = ["Cut", "Handoff", "Isolation", "Miscellaneous", "Offscreen", "P&R Ball Handler", "P&R Roll Man", "Post-Up", "Putbacks", "Spot-Up", "Transition"]
  types = ["Post-Up", "P&R Ball Handler", "Isolation", "Transition", "Offscreen", "Handoff", "Spot-Up", "P&R Roll Man", "Cut", "Putbacks"]
  players = Hash.new { |h, k| h[k] = {} }
  data.each do |player|
    id = [player['Player'], 1, player['Team'], 0, player['Season']].join('_')
    if players[id][player['Play Type']].present?
      # p player
      # p result[id][player['Play Type']]
      if players[id][player['Play Type']]['GP'].to_i < player['GP'].to_i
        players[id][player['Play Type']] = player
      end
    else
      players[id][player['Play Type']] = player
    end
  end

  original_csv = Hash.new { |h, k| h[k] = {} }
  players.merge(parse_ncaa_csv).each do |key, player|
    next if player.values.map { |ddd| ddd['Poss'].to_i }.sum <= 100
    types.each do |type|
      original_csv[key][type] = player[type].try(:[], '% Time').to_s.gsub('%', '').to_f
    end
  end
  CSV.open("../result/play_types.data", "wb") do |csv|
    normalised = normalise_by_count(original_csv)
    p normalised.size
    normalised.each do |key, value|
      csv << [key] + types.map do |type|
        value[type]
      end
    end
  end
end

def parse_play_styles
  data = []
  CSV.open('../data/player_style.csv', 'r') do |rows|
    headers = nil
    rows.each do |row|
      player = {}
      if !headers
        headers = row
      else
        headers.each_with_index do |header, i|
          player[header] = row[i]
        end
      end
      data << player if player.any?
    end
  end

  # types = ["Cut", "Handoff", "Isolation", "Miscellaneous", "Offscreen", "P&R Ball Handler", "P&R Roll Man", "Post-Up", "Putbacks", "Spot-Up", "Transition"]
  types = data.first.keys.reject { |key| key == 'name' }
  p data.first
  p types
  original_csv = Hash.new { |h, k| h[k] = {} }
  data.each do |player|
    key = player['name']
    types.each do |type|
      original_csv[key][type] = player[type].to_f
    end
  end
  CSV.open("../result/play_styles.csv", "wb") do |csv|
    # csv << ['name'] + types
    normalised = normalise_by_count(original_csv.dup)
    normalised.each do |key, value|
      csv << [key] + types.map do |type|
        "#{original_csv[key][type]}(#{value[type]})"
      end
    end
  end
end

def parse_csv_by_season(player_name='LaMarcus Aldridge')
  data = []
  CSV.open('../data/play_types.csv', 'r') do |rows|
    headers = nil
    rows.each do |row|
      player = {}
      if !headers
        headers = row
      else
        headers.each_with_index do |header, i|
          player[header] = row[i]
        end
      end
      data << player if player.any?
    end
  end
  # types = ["Cut", "Handoff", "Isolation", "Miscellaneous", "Offscreen", "P&R Ball Handler", "P&R Roll Man", "Post-Up", "Putbacks", "Spot-Up", "Transition"]
  types = ["Post-Up", "P&R Ball Handler", "Isolation", "Transition", "Offscreen", "Handoff", "Spot-Up", "P&R Roll Man", "Cut", "Putbacks"]
  cn_types = ["背身", "挡拆持球", "面框单打", "转换进攻", "绕掩护", "手递手", "定点突投", "挡拆接球", "空切", "二次进攻"]
  players = Hash.new { |h, k| h[k] = {} }
  data.each do |player|
    id = [player['Player'], player['Player'].downcase, player['Team'], 0, player['Season']].join('_')
    if players[id][player['Play Type']].present?
      if players[id][player['Play Type']]['GP'].to_i < player['GP'].to_i
        players[id][player['Play Type']] = player
      end
    else
      players[id][player['Play Type']] = player
    end
  end
  p players.keys.select { |k| k.include?(player_name) }
  original_csv = Hash.new { |h, k| h[k] = {} }
  players.each do |key, player|
    next if player.values.map { |ddd| ddd['Poss'].to_i }.sum <= 100
    types.each do |type|
      original_csv[key][type] = player[type].try(:[], '% Time').to_s.gsub('%', '').to_f.round(2)
    end
  end
  CSV.open("../result/play_types_trend.csv", "wb") do |csv|
    csv << ['date'] + cn_types + ['其他']
    original_csv.keys.select { |k| k.to_s.include?(player_name) }.each do |key|
      value = original_csv[key]
      row = [key.split('_').last.split('-').first] + types.map do |type|
        value[type]
      end
      row << 100 - types.map { |type| value[type] }.sum
      csv << row
    end
  end

  normalised = normalise_by_count(original_csv)
  years = (2004..2017).to_a
  result = types.map do |type|
    ["attribute", "minus", "values", "attributeUnique", "id"]
    player_ids = normalised.keys.select { |k| k.to_s.include?(player_name) }
    values = years.map do |year|
      season = "#{year}-#{(year+1).to_s.last(2)}"
      key = player_ids.find { |player_id| player_id.include?(season) }
      key ? normalised[key][type].round(3) : nil
    end
    {attribute: cn_types[types.index(type)], attributeUnique: cn_types[types.index(type)], id: type.downcase, minus: 'm', values: values}
  end
  File.open("../result/attributes.json", "w") do |f|
    f.write(result.to_json)
  end
end

def parse_csv_all_player_by_season()
  data = []
  CSV.open('../data/play_types.csv', 'r') do |rows|
    headers = nil
    rows.each do |row|
      player = {}
      if !headers
        headers = row
      else
        headers.each_with_index do |header, i|
          player[header] = row[i]
        end
      end
      data << player if player.any?
    end
  end
  # types = ["Cut", "Handoff", "Isolation", "Miscellaneous", "Offscreen", "P&R Ball Handler", "P&R Roll Man", "Post-Up", "Putbacks", "Spot-Up", "Transition"]
  types = ["Post-Up", "P&R Ball Handler", "Isolation", "Transition", "Offscreen", "Handoff", "Spot-Up", "P&R Roll Man", "Cut", "Putbacks"]
  cn_types = ["背身", "挡拆持球", "面框单打", "转换进攻", "绕掩护", "手递手", "定点突投", "挡拆接球", "空切", "二次进攻"]
  players = Hash.new { |h, k| h[k] = {} }
  data.each do |player|
    id = [player['Player'], player['Player'].downcase, player['Team'], 0, player['Season']].join('_')
    if players[id][player['Play Type']].present?
      if players[id][player['Play Type']]['GP'].to_i < player['GP'].to_i
        players[id][player['Play Type']] = player
      end
    else
      players[id][player['Play Type']] = player
    end
  end
  p players.keys.select { |k| k.include?('antetokounmpo') }

  original_csv = Hash.new { |h, k| h[k] = {} }
  players.each do |key, player|
    # next if player.values.map { |ddd| ddd['Poss'].to_i }.sum <= 100
    types.each do |type|
      original_csv[key][type] = player[type].try(:[], '% Time').to_s.gsub('%', '').to_f.round(2)
    end
  end
  p players.keys.size
  ids = players.keys.map { |k| k.split('_')[1] }.uniq
  years = (2004..2016).to_a
  d = ids.map do |id|
    keys = players.keys.select { |k| k.split('_')[1] == id }
    name = keys[0].split('_').first
    values = years.map do |year|
      season = "#{year}-#{(year+1).to_s.last(2)}"
      key = keys.select { |k| k.include? season }.last
      next unless key
      type_values = types.map do |type|
        [cn_types[types.index(type)], original_csv[key][type]]
      end.to_h.merge({date: year})
      type_values['其他'] = 100 - types.map do |type|
        original_csv[key][type]
      end.sum
      type_values
    end.compact
    [id, {name: name, values: values}]
  end.to_h
  p d.values.first
  File.open("../result/play_types_trend.json", "w") do |f|
    f.write(d.to_json)
  end
end

def parse_pass_data
  teams = Hash.new { |h, k| h[k] = {players: {}, passes: []} }
  headers = []
  rows = CSV.read('../data/pass_data.csv', encoding: 'ISO-8859-1')
  rows.each do |row|
    if headers.blank?
      headers = row.map { |col| col.force_encoding('GBK').encode('utf-8') }
    else
      player = {}
      headers.each_with_index do |header, i|
        player[header] = row[i]
      end
      teams[player['球队']][:players][player[' 传球球员ID']] = {name: player['传球球员'].split(', ').reverse.join(' '), id: player[' 传球球员ID'], time: player['传球球员上场时间'].to_i}
      teams[player['球队']][:players][player['接球球员ID']] = {name: player['接球球员'].split(', ').reverse.join(' '), id: player['接球球员ID'], time: player['接球球员上场时间'].to_i}
      teams[player['球队']][:passes] << player
    end
  end
  data = Hash.new { |h, k| h[k] = {} }
  teams.each do |team_name, team|
    result = {nodes: [], links: []}
    players = team[:players].values.sort_by { |v| v[:time] }.last(9)
    ids = players.map { |node| node[:id] }
    x_start = 220
    x_end = 1268 - 597 + 50
    y_start = 50
    y_end = 300
    x = x_start
    y = y_start
    x_change = 250
    y_change = 200
    coods = []

    players.each_with_index do |player, i|
      result[:nodes] << player.merge({Number: i, Status: "starting"})
      coods << {x: x, y: y}
      x = x + x_change
      if x > x_end
        x = x_start
        y = y + y_change
      end
    end
    [4, 0, 1, 2, 3, 5, 6, 7, 8].reverse.each_with_index do |i, index|
      result[:nodes][index] = result[:nodes][index].update(coods[i])
    end
    team[:passes].each do |pass|
      source = ids.index(pass[' 传球球员ID'])
      target = ids.index(pass['接球球员ID'])
      next unless source && target
      time = pass['场均传球次数']
      result[:links] << {source: source, target: target, time: time}
    end
    data[team_name][:combined] = result
  end

  teams.each do |team_name, team|
    result = {nodes: [], links: []}
    players = team[:players].values.select { |v| v[:time] > 800 }
    ids = players.map { |node| node[:id] }
    p players
    players.each_with_index do |player, i|
      passes = team[:passes].select { |pass| pass[' 传球球员ID'] == player[:id] }
      result[:nodes] << player.merge({Number: i, passes: passes.sum { |pass| pass['场均传球次数'].to_f.round(1) }})
    end
    team[:passes].each do |pass|
      source = ids.index(pass[' 传球球员ID'])
      target = ids.index(pass['接球球员ID'])
      next unless source && target
      time = pass['场均传球次数'].to_f.round(1)
      result[:links] << {source: source, target: target, time: time}
    end
    data[team_name][:all] = result
  end

  File.open("../result/passes.json", "w") do |f|
    f.write(data.to_json)
  end
end

def parse_transfer_links
  headers = []
  result = {nodes: [], links: []}
  teams = {}
  transfers = []
  rows = CSV.read('../data/transfer_links.csv', encoding: 'ISO-8859-1')
  rows.each do |row|
    if headers.blank?
      headers = row.map { |col| col.force_encoding('GBK').encode('utf-8') }
    else
      transfer = {}
      headers.each_with_index do |header, i|
        transfer[header] = row[i]
      end
      if transfer['Old Team'] != transfer['New Team'] && ([transfer['New Team'], transfer['Old Team']] & TEAMS.keys).size > 1
        teams[transfer['Old Team']] = {id: transfer['Old Team'], name: transfer['Old Team'], conference: TEAMS[transfer['Old Team']]['conference']}
        teams[transfer['New Team'] + '_new'] = {id: transfer['New Team'], name: transfer['New Team'], conference: TEAMS[transfer['New Team']]['conference']}
        transfers << transfer
      end
    end
  end
  p teams
  teams = teams.sort_by {|k, v| v[:conference]+v[:id]}.to_h
  indexes = {}
  teams.each_with_index do |(k, v), index|
    indexes[k] = index
    result[:nodes] << v
  end
  transfers.each do |transfer|
    current = result[:links].find {|d| d[:source] == indexes[transfer['Old Team']] && d[:target] == indexes[transfer['New Team']+ '_new']}
    if current
      current[:value] += transfer['16-17 WS'].to_f
    else
      result[:links] << {source: indexes[transfer['Old Team']], target: indexes[transfer['New Team']+ '_new'], value: transfer['16-17 WS'].to_f}
    end
  end

  File.open("../result/summer_transfers.json", "w") do |f|
    f.write({all: {all: result}}.to_json)
  end
end

def parse_transfer_link_conference
  headers = []
  result = {nodes: [], links: []}
  teams = {}
  transfers = []
  conferences = {}
  rows = CSV.read('../data/transfer_links.csv', encoding: 'ISO-8859-1')
  rows.each do |row|
    if headers.blank?
      headers = row.map { |col| col.force_encoding('GBK').encode('utf-8') }
    else
      transfer = {}
      headers.each_with_index do |header, i|
        transfer[header] = row[i]
      end
      if transfer['Old Team'] != transfer['New Team'] && ([transfer['New Team'], transfer['Old Team']] & TEAMS.keys).size > 1
        teams[transfer['Old Team']] = {id: transfer['Old Team'], name: transfer['Old Team'], conference: TEAMS[transfer['Old Team']]['conference']}
        teams[transfer['New Team'] + '_new'] = {id: transfer['New Team'], name: transfer['New Team'], conference: TEAMS[transfer['New Team']]['conference']}
        conferences[TEAMS[transfer['Old Team']]['conference']] = {id: TEAMS[transfer['Old Team']]['conference'], name: TEAMS[transfer['Old Team']]['conference'], conference: TEAMS[transfer['Old Team']]['conference']}
        conferences[TEAMS[transfer['New Team']]['conference'] + '_new'] = {id: TEAMS[transfer['New Team']]['conference'], name: TEAMS[transfer['New Team']]['conference'], conference: TEAMS[transfer['New Team']]['conference']}
        transfers << transfer
      end
    end
  end
  conferences = conferences.sort_by {|k, v| v[:conference]+v[:id]}.to_h
  indexes = {}
  conferences.each_with_index do |(k, v), index|
    indexes[k] = index
    result[:nodes] << v
  end
  transfers.each do |transfer|
    current = result[:links].find {|d| d[:source] == indexes[TEAMS[transfer['Old Team']]['conference']] && d[:target] == indexes[TEAMS[transfer['New Team']]['conference']+ '_new']}
    if current
      current[:value] += transfer['16-17 WS'].to_f
    else
      result[:links] << {source: indexes[TEAMS[transfer['Old Team']]['conference']],
                         target: indexes[TEAMS[transfer['New Team']]['conference']+ '_new'],
                         value: transfer['16-17 WS'].to_f}
    end
  end

  File.open("../result/summer_transfers.json", "w") do |f|
    f.write({all: {all: result}}.to_json)
  end
end
def parse_transfer_data
  headers = []
  result = {nodes: [], links: []}
  teams = {}
  transfers = []
  rows = CSV.read('../data/nba_transfer.csv', encoding: 'ISO-8859-1')
  rows.each do |row|
    if headers.blank?
      headers = row.map { |col| col.force_encoding('GBK').encode('utf-8') }
    else
      transfer = {}
      headers.each_with_index do |header, i|
        transfer[header] = row[i]
      end
      if transfer['OTm'] != transfer['NTm']
        teams[transfer['OTm']] = {y: transfer['原N'].to_f * 10 , x: transfer['原W'].to_f * 10 + 1500, id: transfer['OTm'], name: transfer['OTm'], passes: (teams[transfer['OTm']].try(:[], :times).to_i + 1), Status: 'starting'}
        teams[transfer['NTm'] + '_new'] = {y: transfer['现N'].to_f * 10 , x: transfer['现W'].to_f * 10 + 1500, id: transfer['NTm'], name: transfer['NTm'], passes: (teams[transfer['NTm']].try(:[], :times).to_i + 1), Status: 'starting'}
        transfers << transfer

      end
    end
  end
  headers = []
  players = {}
  CSV.read('../data/transfer_players.csv', encoding: 'ISO-8859-1').each do |row|
    if headers.blank?
      headers = row.map { |col| col.force_encoding('GBK').encode('utf-8') }
    else
      player = {}
      headers.each_with_index do |header, i|
        player[header] = row[i]
      end
      players[player['Player']] = player
    end
  end
  teams = teams.sort_by {|k, v| v[:id]}.to_h
  indexes = {}
  teams.each_with_index do |(k, v), index|
    indexes[k] = index
    v[:Number] = index
    result[:nodes] << v
  end
  transfers.each do |transfer|
    current = result[:links].find {|d| d[:source] == indexes[transfer['OTm']] && d[:target] == indexes[transfer['NTm']+ '_new']}
    p players[transfer['Player']]['WS'], transfer['Player']
    if current
      current[:value] += players[transfer['Player']]['WS'].to_f
    else
      result[:links] << {source: indexes[transfer['OTm']], target: indexes[transfer['NTm']+ '_new'], value: players[transfer['Player']]['WS'].to_f}
    end
  end

  File.open("../result/summer_transfers.json", "w") do |f|
    f.write({all: {all: result}}.to_json)
  end
end

def test_format
  data = JSON.parse(File.read('../data/forenames.json'))
  result = []
  keys = data[0].keys
  p keys
  data.each do |d|
    dd = {}
    keys.each do |key|
      dd[key.gsub('forename', 'attribute').gsub('births', 'values').gsub('sex', 'minus')] = d[key]
    end
    result << dd
  end
  File.open("../result/attributes.json", "w") do |f|
    f.write(result.to_json)
  end
end

# parse_csv
# parse_csv_all_player_by_season
# test_format
# parse_pass_data
# parse_play_styles
# parse_transfer_data
parse_transfer_links
# parse_transfer_link_conference