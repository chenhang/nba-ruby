class BasicStats < NbaApi::HashObject
  def path_name
    self.class.name.split("::").last.underscore
  end

  def find params = {}
    NbaApi::Client.find(path_name, params)
  end

  def self.apis
    {}
  end

  def self.default_params
    {}
  end

  def refresh!
    find(id)
  end
end
