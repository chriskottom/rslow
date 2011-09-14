module RSlow
  module Rules
   class RequestCountRule < RSlow::Rule
     def evaluate(page)
       @params["resources"].each do |res|
         res["count"] = case res["type"]
         when "script"
           page.scripts.count
         when "css"
           page.stylesheets.count
         when "css_image"
           catted_content = page.stylesheets.reduce("") {|cat, css| cat + css.contents }
           md = catted_content.match(/background(-image)?\s*\:.*url\((.*)\)/)
           md.to_a.uniq.count
         else
           0
         end
       end
     end

     def score
       deductions = @params["resources"].map do |res|
         (res["count"].to_i - res["max"].to_i) * res["points"].to_i
       end
       100 - (deductions.inject(0) {|sum, ded| sum + (ded < 0 ? 0 : ded) })
     end
   end
  end
end
