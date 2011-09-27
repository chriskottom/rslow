module RSlow
  module Resources
    class CssResource
      IMAGE_MIME_TYPES = %w(image/gif image/jpeg image/pjpeg image/png) +
                         %w(image/svg+xml image/tiff image/vnd.microsoft.icon)

      include Resource

      attr_accessor :children

      def setup
        fetch_css_images
      end

      def images
        @images ||= children.select do |child|
          IMAGE_MIME_TYPES.include?(child.content_type)
        end
      end

      private
      def fetch_css_images
        @children = []

        image_urls = @contents.scan(/url\(([^\)]*)\)/).flatten
        image_urls.each do |url|
          unless url.nil? || url.empty?
            res = RSlow::Resources::BasicResource.new(url, self) rescue nil
            @children << res if res
          end
        end
      end
    end
  end
end
