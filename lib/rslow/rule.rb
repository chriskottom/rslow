module RSlow
  class Rule
    attr_accessor  :name, :points, :weight

    def initialize(params={})
      @params = params
      @name = @params["name"]
      @points = @params["points"]
      @weight = @params["weight"]
    end

    def grade
      if score >= 90
        "A"
      elsif score >= 80
        "B"
      elsif score >= 70
        "C"
      elsif score >= 60
        "D"
      elsif score >= 50
        "E"
      else
        "F"
      end
    end
  end
end
