module RSlow
  module Rules
    class GzipRule < RSlow::Rule
      GZIP_ENCODING         = "gzip"
      MAX_UNCOMPRESSED_SIZE = 500

      def evaluate(resource)
        score = compute_score(resource)

        {
           title: self[:title],
           score: score,
           grade: RSlow::Grading.for_score(score)
         }
      end

      def compute_score(root_resource)
        tested_resources = []
        tested_resources << root_resource
        tested_resources += root_resource.scripts
        tested_resources += root_resource.stylesheets

        uncompressed = tested_resources.select do |resource|
          GZIP_ENCODING == resource.content_encoding ||
            (resource.content_length && 
             resource.content_length <= MAX_UNCOMPRESSED_SIZE)
        end

        RSlow::Rule::MAX_SCORE - (uncompressed.count * self[:deduction])
      end
    end
  end
end
