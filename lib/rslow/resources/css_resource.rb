module RSlow
  module Resources
    class CssResource
      include Resource

      attr_accessor :children

      def setup
        @children = []
      end
    end
  end
end
