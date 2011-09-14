require "net/http"
require "net/https"
require "uri"


module RSlow
  class Resource
    attr_accessor  :url, :headers, :code, :message, :contents
    attr_accessor  :parent

    def initialize(url, parent=nil)
      @parent = parent
      url = URI.escape(url)
      if url =~ /\Ahttp:\/\//
        @url = URI.parse(url)
      else
        @url = parent.url.merge(url)
      end

      request = Net::HTTP.new(@url.host, @url.port)
      request.use_ssl = true if @url.scheme == "https"
      response = request.get(@url.request_uri)

      @headers = response.to_hash
      @code = response.code
      @message = response.message
      @contents = response.body
    end
  end
end
