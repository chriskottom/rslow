module RSlow
  module Rules
    class UrlRedirectRule < RSlow::Rule
      def compute_deductions(resource)
        all_resources = [ resource ] +
                        resource.scripts +
                        resource.stylesheets +
                        resource.images
        redirect_resources = all_resources.select do |resource|
          resource.code =~ /\A(301|302)\Z/
        end

        redirect_resources.count * self[:points_per_redirect]
      end
    end
  end
end
