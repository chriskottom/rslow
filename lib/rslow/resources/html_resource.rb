require "nokogiri"


module RSlow
  module Resources
    class HtmlResource
      include Resource

      attr_accessor  :doc, :scripts, :stylesheets, :images, :children

      def setup
        @scripts, @stylesheets, @images, @children = [], [], [], []

        @doc = Nokogiri::HTML(@contents)
        fetch_script_resources
        fetch_stylesheet_resources
        fetch_image_resources


      end


      private
      def fetch_script_resources
        @doc.xpath(".//script").each do |js|
          url = js["src"]
          unless url.nil? || url.empty?
            res = JsResource.new(url, self) rescue nil
            @scripts << res if res
            @children << res if res
          end
        end
      end

      def fetch_stylesheet_resources
        @doc.xpath(".//link").each do |css|
          next unless css["rel"] == "stylesheet"
          url = css["href"]
          unless url.nil? || url.empty?
            res = CssResource.new(url, self) rescue nil
            @stylesheets << res if res
            @children << res if res
          end
        end 
      end

      def fetch_image_resources
        @doc.xpath(".//img").each do |img|
          url = img["src"]
          unless url.nil? || url.empty?
            res = BasicResource.new(url, self) rescue nil
            @images << res if res
            @children << res if res
          end
        end
      end
    
    end
  end
end
