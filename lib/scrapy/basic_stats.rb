class BasicStats < HashObject
  # def path_name
  #   self.class.name.split("::").last.underscore
  # end

  def self.apis
    {}
  end

  def self.default_params
    {}
  end

  def all params = {}
    get(:all, params)
  end

  def find params = {}
    get(:find, params)
  end

  def get(type, params = {})
    nba_class = self.class
    response = http_get nba_class.apis[type], params.merge(default_params[type])
    create response
  end

  def http_get(api, params = {})
    uri = URI.parse(api)
    uri.query = URI.encode_www_form(params) unless params.empty?
    grab(uri)
  end

  def grab(uri)
    http = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Get.new uri.request_uri
    p uri
    response = http.request request
    JSON.parse(response.body)
  end

  def refresh!
    find(id)
  end
end