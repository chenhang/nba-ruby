class BasicStats < NbaApi::HashObject
  def path_name
    self.class.name.split("::").last.underscore
  end

  def self.apis
    {}
  end

  def self.default_params
    {}
  end

  def get(api, params = {})
    uri = URI.parse(api)
    uri.query = URI.encode_www_form(params) unless params.empty?
    http_get(uri)
  end

  def find(path, params = {})
    nba_class = class_from_path path
    response = get nba_class.api, params
    nba_class.create response
  end

  def http_get(uri)
    http = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Get.new uri.request_uri
    response = http.request request
    JSON.parse(response.body) rescue nil
  end

  def refresh!
    find(id)
  end
end
