module RSlow
  module Rules
    class DomElementsRule < RSlow::Rule
      def compute_deductions(resource)
        document = resource.document

        node_count = 0
        document.traverse { |node| node_count += 1 }

        if node_count <= self[:max_allowed_nodes]
          0
        else
          counted_nodes = node_count - self[:max_allowed_nodes] 
          counted_nodes / self[:range] * self[:points_per_range]
        end
      end
    end
  end
end
