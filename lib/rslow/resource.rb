require "net/http"
require "net/https"
require "uri"


module RSlow
  module Resource
    EXPIRES_DATE_FORMAT = "%a, %d %b %Y %H:%M:%S %Z"
    HEADER_NAMES = {
      content_type:       "Content-Type",
      content_encoding:   "Content-Encoding",
      content_length:     "Content-Length",
      expires:            "Expires",
      cache_control:      "Cache-Control"
    }

    attr_reader  :parent, :url, :headers, :code, :message, :contents

    def initialize(url, parent=nil)
      @parent = parent
      parse_url_string(url)
      load_resource

      setup if self.class.method_defined?(:setup)
    end

    def content_type
      @headers[HEADER_NAMES[:content_type]]
    end

    def content_encoding
      @headers[HEADER_NAMES[:content_encoding]]
    end

    def cache_control
      @headers[HEADER_NAMES[:cache_control]]
    end

    def content_length
      header_value = @headers[HEADER_NAMES[:content_length]]
      header_value && header_value.to_i
    end

    def expires
      header_value = @headers[HEADER_NAMES[:expires]]
      header_value && DateTime.strptime(header_value, EXPIRES_DATE_FORMAT)
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

      @headers = response
      @code = response.code
      @message = response.message
      @contents = response.body
    end
  end
end
