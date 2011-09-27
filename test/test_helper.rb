require_relative "../lib/rslow"

require "test/unit"
require "rslow"

module TestHelper
  TEST_URL          = "http://www.ruby-lang.org/en/"
  TEST_RELATIVE_URL = "/images/download.gif"

  TEST_CSS_FILE     = File.join(File.dirname(__FILE__), "test.css")
  TEST_HTML_FILE    = File.join(File.dirname(__FILE__), "test.html")

  TEST_CSS          = File.read(TEST_CSS_FILE)
  TEST_HTML         = File.read(TEST_HTML_FILE)

  HTTP_SUCCESS      = { code: "200", message: "OK" }
  GIF_SUCCESS       = HTTP_SUCCESS.merge({ :"Content-Type" => "image/gif" })


  def mock_http_response
    http_mock = mock("Net::HTTPResponse")
    http_mock.stubs(code:     HTTP_SUCCESS[:code],
                    message:  HTTP_SUCCESS[:message],
                    body:     TEST_HTML,
                    to_hash:  HTTP_SUCCESS)
    http_mock
  end

  def mock_css_response
    css_mock = mock("Net::HTTPResponse")
    css_mock.stubs(code:     HTTP_SUCCESS[:code],
                   message:  HTTP_SUCCESS[:message],
                   body:     TEST_CSS,
                   to_hash:  HTTP_SUCCESS)
    css_mock
  end

  def mock_image_resource
    image_mock = mock("RSlow::Resources::Basic_Resource")
    image_mock.stubs(code:         GIF_SUCCESS[:code],
                     message:      GIF_SUCCESS[:message],
                     body:         "",
                     content_type: GIF_SUCCESS[:"Content-Type"])
    image_mock
  end
end

