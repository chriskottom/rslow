module RSlow
  module Rules
    class GzipRule < RSlow::Rule
      GZIP_ENCODING         = "gzip"
      MAX_UNCOMPRESSED_SIZE = 500

      def compute_score(root_resource)
        resources_to_test = [ root_resource ] +
                            root_resource.scripts + 
                            root_resource.stylesheets

        uncompressed = resources_to_test.select do |resource|
          GZIP_ENCODING == resource.content_encoding ||
            (resource.content_length && 
             resource.content_length <= MAX_UNCOMPRESSED_SIZE)
        end

        RSlow::Rule::MAX_SCORE - (uncompressed.count * self[:deduction])
      end
    end
  end
end
