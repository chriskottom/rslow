require "delegate"

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
      rule_evaluations = self.map { |rule| rule.evaluate(resource) }
      rule_evaluations.to_json
    end

  end
end

    #def initialize(rules_file)
    #  @rules = { }

#      rules_yaml = YAML::load_file(rules_file)
#      rules_yaml.each do |r|
#        class_components = r["class"].split("::")
#        rule_class = class_components.inject(Object, :const_get)
#        rule = rule_class.new(r["rule_params"])
#        @rules[ r["rule_params"]["name"] ] = rule
#      end
#    end

#    def evaluate(page)
#      @evaluation = { }
#      @rules.each_pair do |name, rule|
#        rule.evaluate(page)
#        @evaluation[name] = rule
#      end
#    end

#    def total_score
#      raw_score = @evaluation.values.inject(0) do |sum, rule|
#        sum + (rule.weight.to_i * rule.score)
#      end

#      (raw_score / total_weight).to_i
#    end

#    def total_grade
#      score = total_score
#      if score >= 90
#        "A"
#      elsif score >= 80
#        "B"
#      elsif score >= 70
#        "C"
#      elsif score >= 60
#        "D"
#      elsif score >= 50
#        "E"
#      else
#        "F"
#      end
#    end

#    def total_weight
#      @evaluation.values.inject(0) do |sum, rule|
#        sum + rule.weight.to_i
#      end
#    end

#    def print_evaluation
#      puts "Overall grade:  #{ total_grade }"
#      puts "Overall score:  #{ total_score }"
#      @evaluation.each_pair do |name, rule|
#        puts "    #{ rule.grade }   #{ rule.score.to_s.ljust(2) }   #{ name }"
#      end
#    end

