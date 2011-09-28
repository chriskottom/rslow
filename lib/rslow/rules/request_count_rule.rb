module RSlow
  module Rules
    class RequestCountRule < RSlow::Rule
      def compute_deductions(resource)
        total_deductions = 0

        self[:resources].each do |type, properties|
          resource_count = case type
          when :script
            resource.scripts.count
          when :css
            resource.stylesheets.count
          when :css_image
            count_unique_css_images(resource)
          else
            0
          end

          total_deductions += compute_deduction(resource_count, properties)
        end

        total_deductions
      end

      def count_unique_css_images(resource)
        css_resources = resource.stylesheets
        css_images = css_resources.reduce([]) do |images, css|
          images += css.images
        end
        css_image_urls = css_images.map { |image| image.url.to_s }

        css_image_urls.uniq.count
      end

      def compute_deduction(count, rule_config)
        if count < rule_config[:maximum_allowed].to_i
          0
        else
          (count - rule_config[:maximum_allowed].to_i) * 
            rule_config[:deduction].to_i
        end
      end
    end
  end
end
