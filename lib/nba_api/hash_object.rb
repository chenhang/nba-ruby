class HashObject
  def initialize(hash)
    hash.each { |k, v| to_self k, detect(v) }
  end

  def detect v
    if v.class == Array
      v.map { |item| detect item }
    else
      v.class == Hash ? HashObject.new v : v
    end
  end

  def to_self k, v
    self.instance_variable_set("@#{k}", v)
    self.class.send(:define_method, k, proc { self.instance_variable_get("@#{k}") })
    self.class.send(:define_method, "#{k}=", proc { |v| self.instance_variable_set("@#{k}", v) })
  end
end