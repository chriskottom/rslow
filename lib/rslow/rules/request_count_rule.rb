module RSlow
  module Rules
    class RequestCountRule < RSlow::Rule
      def evaluate(resource)
        score = compute_score(resource)

        {
           title: self[:title],
           score: score,
           grade: RSlow::Grading.for_score(score)
         }
      end

      private
      def compute_score(resource)
        deductions = []

        self[:resources].each do |type, properties|
          resource_count = case type
          when :script
            resource.scripts.count
          when :css
            resource.stylesheets.count
          when :css_image
           catted_content = resource.stylesheets.reduce("") {|cat, css| cat + css.contents }
           md = catted_content.match(/background(-image)?\s*\:.*url\((.*)\)/)
           md.to_a.uniq.count
          else
            0
          end

          deductions << compute_deduction(resource_count, properties)
        end

        Rule::MAX_SCORE - deductions.reduce(:+)
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
