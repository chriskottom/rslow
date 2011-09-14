require "nokogiri"


module RSlow
  class HtmlResource < ParsableResource
    attr_accessor  :doc, :scripts, :stylesheets, :images

    def initialize(url)
      super
      @doc = Nokogiri::HTML(@contents)
      fetch_script_resources
      fetch_stylesheet_resources
      fetch_image_resources
    end


    private
    def fetch_script_resources
      @scripts = []
      @doc.xpath(".//script").each do |js|
        url = js["src"]
        res = JsResource.new(url, self) unless url.nil? || url.empty?
        @scripts << res
        @children << res
      end 
   end

    def fetch_stylesheet_resources
      @stylesheets = []
      @doc.xpath(".//link").each do |css|
        next unless css["rel"] == "stylesheet"
        url = css["href"]
        res = CssResource.new(url, self) unless url.nil? || url.empty?
        @stylesheets << res
        @children << res
      end 
    end

    def fetch_image_resources
      @images = []
      @doc.xpath(".//img").each do |img|
        url = img["src"]
        res = Resource.new(url, self) unless url.nil? || url.empty?
        @images << res
        @children << res
      end
    end
    
  end
end
