require "net/http"
require "net/https"
require "uri"


module RSlow
  module Resource
    attr_reader  :parent, :url, :headers, :code, :message, :contents

    def initialize(url, parent=nil)
      @parent = parent

      parse_url_string(url)

      response = request_resource

      @headers = response.to_hash
      @code = response.code
      @message = response.message
      @contents = response.body

      #
      #  TO-DO: try to improve this construct
      #
      setup if self.class.method_defined?(:setup)
    end

    private
    def parse_url_string(url)
      url = URI.escape(url)
      if url =~ /\Ahttp:\/\//
        @url = URI.parse(url)
      elsif @parent
        @url = @parent.url.merge(url)
      else
        raise URI::InvalidURIError, "Cannot process relative URI without parent"
      end
    end

    def request_resource
      request = Net::HTTP.new(@url.host, @url.port)
      request.use_ssl = true if @url.scheme == "https"
      request.get(@url.request_uri)
    end

  end
end
