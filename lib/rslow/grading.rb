module RSlow
  module Grading
    class << self
      def for_score(score)
        if score >= 90
          :A
        elsif score >= 80
          :B
        elsif score >= 70
          :C
        elsif score >= 60
          :D
        elsif score >= 50
          :E
        else
          :F
        end
      end
    end
  end
end
