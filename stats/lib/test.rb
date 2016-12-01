require 'json'
require 'csv'
require 'active_support/all'

SHOTING_CATEGORIES = ["GeneralRange", "DribbleRange", "ClosestDefenderRange", "ClosestDefender10ftPlusRange", "TouchTimeRange"]
COMPARE_CATEGORIES = ["GeneralRange", 'GeneralStats', 'TrackingStats']

json_data = JSON.parse(File.read('data/merged_league.json'))

demo = json_data['201566']

PERCENT_DIFF = 0.05
FREQS = ["DRIVE_FREQUENCY", "#CATCH_SHOOT_FREQUENCY", "#PULL_UP_FREQUENCY", "PAINT_TOUCH_FREQUENCY", "POST_TOUCH_FREQUENCY", "ELBOW_TOUCH_FREQUENCY"].map { |k| [k, PERCENT_DIFF] }
SCORING_FREQS = ["PCT_PTS_FT", "#PCT_PTS_PAINT", "#PCT_PTS_2PT", "#PCT_PTS_3PT", "#PCT_PTS_2PT_MR", "PCT_AST_FGM"].map { |k| [k, PERCENT_DIFF] }
SHOT_FREQS = [['FG2A_FREQUENCY', PERCENT_DIFF], ['FG3A_FREQUENCY', PERCENT_DIFF]]
COMPARE_KEYS = {'GeneralStats' => {'Scoring' => SCORING_FREQS}, 'TrackingStats' => {'Efficiency' => FREQS}}

def compare(main_category, category, a, b)
  bools = []
  compare_keys = COMPARE_KEYS.try(:[], main_category).try(:[], category) || []
  compare_keys += SHOT_FREQS if SHOTING_CATEGORIES.include?(main_category)

  compare_keys.each do |(key, percent)|
    next if a[key].nil? || b[key].nil?
    bools.push same?(a, b, key, percent)
  end

  [bools.count(true), bools.count(false)]
end

def same?(a, b, key, percent)
  (a[key] - b[key]).abs <= percent
end

def test_simalar data_set, demo
  names = {}
  result = {}
  data_set.each do |k, v|
    sames = 0
    unsames = 0
    name = ''
    v.each do |kk, vv|
      next unless COMPARE_CATEGORIES.include?(kk)
      vv.each do |kkk, vvv|
        name = vvv['PLAYER_NAME']
        counts = compare(kk, kkk, vvv, demo[kk][kkk])
        sames += counts[0]
        unsames += counts[1]
      end
    end
    percent = sames.to_f / (unsames + sames)
    if percent >= 0.8
      names[k] = [name, "#{(percent * 100).to_i}%"]
      result[k] = v
    end
  end
  names
end

json_data.select! { |_, data| (data['GeneralStats']['Base']['MIN']/data['GeneralStats']['Base']['GP'].to_f) > 10 }
# p json_data.first.last['GeneralStats']['Base'].keys

# p test_simalar(json_data, demo).values

