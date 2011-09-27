module RSlow
  module Rules
    class DomElementsRule < RSlow::Rule
      def compute_score(resource)
        document = resource.document

        node_count = 0
        document.traverse { |node| node_count += 1 }

        if node_count <= self[:max_allowed_nodes]
          Rule::MAX_SCORE
        else
          counted_nodes = node_count - self[:max_allowed_nodes] 
          deduction = counted_nodes / self[:range] * self[:points_per_range]
          Rule::MAX_SCORE - deduction
        end
      end
    end
  end
end
