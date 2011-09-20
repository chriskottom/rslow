require "delegate"

module RSlow
  class Rule < DelegateClass(Hash)

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

  end
end
