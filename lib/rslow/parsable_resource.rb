module RSlow
  class ParsableResource < Resource
    attr_accessor  :children

    def initialize(url, parent=nil)
      super
      @children = []
    end
  end
end
