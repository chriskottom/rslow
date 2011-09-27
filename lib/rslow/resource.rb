require "net/http"
require "net/https"
require "uri"


module RSlow
  module Resource
    attr_reader  :parent, :url, :headers, :code, :message, :contents

    def initialize(url, parent=nil)
      @parent = parent
      parse_url_string(url)
      load_resource

      setup if self.class.method_defined?(:setup)
    end

    def content_type
      @headers["Content-Type"]
    end

    def content_encoding
      @headers["Content-Encoding"]
    end

    def content_length
      @headers["Content-Length"]
    end

    private
    def parse_url_string(url)
      url = URI.escape(url)
      @url = URI.parse(url)                # works for fully-qualified URLs

      if @url.scheme.nil? && @parent       # works for relative URLs with parent
        @url = @parent.url.merge(url)
      end

      if @url.scheme.nil?                  # in case there's no parent
        raise URI::InvalidURIError, "Cannot process relative URI without parent"
      end
    end

    def load_resource
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
