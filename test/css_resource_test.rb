require_relative "test_helper"

require "mocha"
require "net/http"
require "uri"

class CssResourceTest < Test::Unit::TestCase
  include TestHelper
  
  def test_css_image_loading
    Net::HTTP.any_instance.stubs(:get).returns(mock_css_response)
    RSlow::Resources::BasicResource.stubs(:new).returns(mock_image_resource)

    resource = RSlow::Resources::CssResource.new(TEST_URL)
    css_image_urls = resource.contents.scan(/url\(([^\)]*)\)/)
    assert_equal(css_image_urls.count, resource.images.count)
  end
end
