require_relative "test_helper"

require "mocha"
require "net/http"
require "uri"

class ResourceTest < Test::Unit::TestCase
  include TestHelper

  TEST_URL          = "http://www.ruby-lang.org/en/"
  TEST_RELATIVE_URL = "/images/download.gif"

  def test_resource_creation
    Net::HTTP.any_instance.expects(:get).returns(mock_http_response)

    resource = RSlow::Resources::BasicResource.new(TEST_URL)
    assert_equal(URI.parse(TEST_URL), resource.url)
    assert_equal(HTTP_SUCCESS, resource.headers)
    assert_equal(TEST_HTML, resource.contents)
    assert_equal(HTTP_SUCCESS[:code], resource.code)
    assert_equal(HTTP_SUCCESS[:message], resource.message)
  end

  def test_resource_with_relative_url
    Net::HTTP.any_instance.stubs(:get).returns(mock_http_response)
    parent = RSlow::Resources::BasicResource.new(TEST_URL)
    child = RSlow::Resources::BasicResource.new(TEST_RELATIVE_URL, parent)

    parent_url, child_url = parent.url, child.url
    assert_equal(parent_url.scheme, child_url.scheme)
    assert_equal(parent_url.userinfo, child_url.userinfo)
    assert_equal(parent_url.host, child_url.host)
    assert_equal(parent_url.port, child_url.port)
    assert_equal(parent_url.registry, child_url.registry)
  end

  def test_resource_with_relative_url_and_no_parent
    assert_raise(URI::InvalidURIError) do
      RSlow::Resources::BasicResource.new(TEST_RELATIVE_URL)
    end
  end
end
