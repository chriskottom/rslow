require "delegate"

module RSlow
  class Rule < DelegateClass(Hash)
    MAX_SCORE = 100
    MIN_SCORE = 0

    # Generate a Rule using the requested implementation class
    # and initialized with the passed options hash.
    def self.generate(type, options={})
      rule_class = RSlow::Rules.const_get(type)

      rule_class.new(options)
    rescue NameError => error
      if type !~ /Rule\Z/
        type = (type.to_s + "Rule").to_sym
        retry
      else
        raise error
      end
    end

    def initialize(options={})
      super(options)
    end

    def evaluate(resource)
      score = compute_score(resource)
      grade = RSlow::Grading.for_score(score)
        
      { title: self[:title], score: score, grade: grade }
    end

    def compute_score(resource)
      deductions = compute_deductions(resource)
      if MAX_SCORE - deductions < MIN_SCORE
        MIN_SCORE
      else
        MAX_SCORE - deductions
      end
    end
  end
end
