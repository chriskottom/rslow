require_relative "../lib/rslow"

require "test/unit"
require "rslow"

module TestHelper
  HTTP_RESPONSE = {
    code:         "200",
    message:      "OK",
    body:         "<html><title>Test</title><body>Page Body</body></html>"
  }

  def mock_http_response
    http_mock = mock("Net::HTTPResponse")
    http_mock.stubs(code:     HTTP_RESPONSE[:code],
                    message:  HTTP_RESPONSE[:message],
                    body:     HTTP_RESPONSE[:body],
                    to_hash:  HTTP_RESPONSE)
    http_mock
  end
end

