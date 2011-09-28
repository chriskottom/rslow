module RSlow
  module Rules
    class ExpiresRule < RSlow::Rule
      MIN_FUTURE_EXPIRATION_DAYS = 2
      MIN_FUTURE_EXPIRATION_SECS = MIN_FUTURE_EXPIRATION_DAYS * 24 * 60 * 60

      def compute_deductions(resource)
        all_resources = resource.scripts +
                        resource.stylesheets +
                        resource.images
        
        soon_expiring_resources = all_resources.select do |resource|
          expires = resource.expires
          cache_control = resource.cache_control

          if expires
            (expires - DateTime.now).to_f < MIN_FUTURE_EXPIRATION_DAYS
          elsif cache_control =~ /max-age=(\d*)/
            expiration_seconds = $1.to_i
            expiration_seconds < MIN_FUTURE_EXPIRATION_SECS
          else
            true
          end
        end

        soon_expiring_resources.count * self[:deduction]
      end
    end
  end
end
