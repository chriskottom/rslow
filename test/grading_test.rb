require_relative "test_helper"


class GradingTest < Test::Unit::TestCase
  include TestHelper

  def test_grading_thresholds
    scores_and_expected_grades = {
      100 => :A, 91 => :A, 90 => :A,
       89 => :B, 81 => :B, 80 => :B,
       79 => :C, 71 => :C, 70 => :C,
       69 => :D, 61 => :D, 60 => :D,
       59 => :E, 51 => :E, 50 => :E,
       49 => :F, 41 => :F, 19 => :F
    }

    scores_and_expected_grades.each_pair do |score, grade|
      assert_equal(grade, RSlow::Grading.for_score(score))
    end
  end
end
