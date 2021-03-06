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

  RULE_CONFIG = [ 
    { type: :"RuleOne",  weight: 10, evaluate: { score: 50 } },
    { type: :"RuleTwo",  weight:  5, evaluate: { score: 75 } },
    { type: :"RuleTres", weight:  8, evaluate: { score: 90 } }
  ]

  def mock_http_response
    unless @http_mock
      @http_mock = mock("Net::HTTPResponse")
      @http_mock.stubs(code:     HTTP_SUCCESS[:code],
                       message:  HTTP_SUCCESS[:message],
                       body:     TEST_HTML,
                       to_hash:  HTTP_SUCCESS)
    end

    @http_mock
  end

  def mock_css_response
    unless @css_mock
      @css_mock = mock("Net::HTTPResponse")
      @css_mock.stubs(code:     HTTP_SUCCESS[:code],
                      message:  HTTP_SUCCESS[:message],
                      body:     TEST_CSS,
                      to_hash:  HTTP_SUCCESS)
    end

    @css_mock
  end

  def mock_image_resource
    unless @image_mock
      @image_mock = mock("RSlow::Resources::Basic_Resource")
      @image_mock.stubs(code:         GIF_SUCCESS[:code],
                        message:      GIF_SUCCESS[:message],
                        body:         "",
                        content_type: GIF_SUCCESS[:"Content-Type"])
    end

    @image_mock
  end

  def mock_rules
    unless @rule_mocks
      @rule_mocks = []
      RULE_CONFIG.each do |config|
        rule_mock = mock("RSlow::Rule")
        rule_mock.stubs(config)
        rule_mock.stubs(:[]).with(:weight).returns(config[:weight])
        @rule_mocks << rule_mock
      end

    end

    @rule_mocks
  end

  def weighted_average_of_fake_scores(scores, weights)
    total_weight = weights.reduce(:+)
    total_weighted_scores = weights.zip(scores).map { |f| f[0] * f[1] }.reduce(:+)
    (total_weighted_scores.to_f / total_weight).round(0)
  end
end

