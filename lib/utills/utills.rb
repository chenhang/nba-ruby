require 'net/https'
class Utils
  def self.https_get(url, params = {}, headers = {})
    puts "GET:#{url}"
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(params) unless params.empty?
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl, http.verify_mode = true, OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    headers.map { |k, v| request[k] = v } unless headers.empty?
    response = http.request(request)
    JSON.parse(response.body) rescue nil
  end

  def self.download(dest, source)
    puts "Will save file to #{dest}"
    puts "Loading #{source}"
    unless File.exist?(dest)
      FileUtils.mkdir_p dest.to_s.pathmap("%d")
      `curl -L '#{source}' > '#{dest}'`
    end
  end
end