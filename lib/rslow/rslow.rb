module RSlow
  extend self

  def configure(&block)
    instance_eval(&block)
  end

  def ruleset(label, &block)
    ruleset = Ruleset.new(label)
    ruleset.instance_eval(&block) if block_given?
    self.rulesets[ruleset.label] = ruleset
    ruleset
  end

  def rulesets
    @rulesets ||= {}
  end

  def page(label, url)
    pages[label] = RSlow::Resources::HtmlResource.new(url)
  end

  def pages
    @pages ||= {}
  end

  def evaluate(page_label, ruleset_label)
    page = pages[page_label]
    ruleset = rulesets[ruleset_label]
    validate_page_and_ruleset(page, ruleset, page_label, ruleset_label)

    ruleset.evaluate(page)
  end

  private
  def validate_page_and_ruleset(page, ruleset, page_label, ruleset_label)
    return if page && ruleset

    message = nil
    if page.nil && ruleset.nil?
      message = "Neither page nor ruleset was found:  " +
                "page => #{ page_label }, ruleset => #{ ruleset_label }"
    elsif page.nil?
      message = "Page not found for label:  #{ page_label }"
    elsif ruleset.nil?
      message = "Ruleset not found for label:  #{ ruleset_label }"
    end

    raise ArgumentError, message
  end
end

