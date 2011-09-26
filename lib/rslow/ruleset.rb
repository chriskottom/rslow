require "delegate"
require "json"

module RSlow
  class Ruleset < DelegateClass(Array)
    attr_reader :label

    def initialize(label="", &block)
      @label = label
      super([])
      instance_eval(&block) if block_given?
    end

    def rule(type, options={})
      self << Rule.generate(type, options)
    end

    def evaluate(resource)
      rule_evaluations = []
      rule_weights = []

      self.each do |rule|
        rule_evaluations << rule.evaluate(resource)
        rule_weights << rule[:weight]
      end

      rule_scores = rule_evaluations.map { |rule_eval| rule_eval[:score] }
      score = compute_weighted_average(rule_scores, rule_weights)
      ruleset_evaluation = {
        score: score,
        grade: RSlow::Grading.for_score(score),
        rule_evaluations: rule_evaluations
      }

      JSON.generate(ruleset_evaluation)
    end

    private
    def compute_weighted_average(scores, weights)
      max_composite_score = RSlow::Rule::MAX_SCORE * weights.reduce(:+)

      composite_score = 0
      scores.each_with_index do |score, index|
        composite_score += score * weights[index]
      end

      normalized_score = (composite_score.to_f / max_composite_score) * 
                           RSlow::Rule::MAX_SCORE
      normalized_score.round(0)
    end
  end
end
