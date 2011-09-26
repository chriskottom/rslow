require_relative "../resource"

module RSlow
  module Resources
    class ParsableResource
      include Resource

      attr_accessor  :children

      def setup
        @children = []
      end
    end
  end
end
