class HashObject
  attr_accessor :id, :current_season
  def initialize(args={})
    self.id = args.fetch(:id, '')
    self.current_season = args.fetch(:current_season, '2014-15')
    save args.fetch(:data, {})
    self.id = self.send("#{self.class.name.downcase}_id").to_s if id.empty? && self.respond_to?("#{self.class.name.downcase}_id")
  end

  def save hash
    hash.each { |k, v| to_self k, detect(v) }
    self
  end

  def create data
    save to_hash(data)
  end

  def detect v
    if v.class == Array
      v.map { |item| detect item }
    else
      v.class == Hash ? self.class.new(data: v) : v
    end
  end

  def to_self k, v
    self.instance_variable_set("@#{k}", v)
    self.class.send(:define_method, k, proc { self.instance_variable_get("@#{k}") })
    self.class.send(:define_method, "#{k}=", proc { |v| self.instance_variable_set("@#{k}", v) })
  end

  def to_hash origin
    {}.tap do |data_sets|
      origin['resultSets'].each do |result_set|
        data_sets[result_set['name'].underscore] = parse_result_set result_set
      end
    end
  end

  def parse_result_set result_set
    [].tap do |data_set|
      result_set['rowSet'].each do |row|
        data_set.push({}.tap do |element|
                        result_set['headers'].each_with_index do |header, index|
                          header.gsub!('PERSON_ID', 'PLAYER_ID')
                          element[header.underscore] = row[index]
                        end
                      end)
      end
    end
  end
end