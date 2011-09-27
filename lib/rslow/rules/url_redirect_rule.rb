module RSlow
  module Rules
    class UrlRedirectRule < RSlow::Rule
      def compute_score(resource)
        all_resources = [ resource ] +
                        resource.scripts +
                        resource.stylesheets +
                        resource.images
        redirect_resources = all_resources.select do |resource|
          resource.code =~ /\A(301|302)\Z/
        end

        Rule::MAX_SCORE - (redirect_resources.count * self[:deduction_per_300])
      end
    end
  end
end
