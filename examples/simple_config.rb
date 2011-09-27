RSlow.configure do
  ruleset :simple_ruleset do                         # creates a Ruleset
    rule :RequestCount,                              # creates a Rule
         title:     "Minimize HTTP requests",
         weight:    8,
         resources: {
           script:    { maximum_allowed: 3, deduction: 3 },
           css:       { maximum_allowed: 2, deduction: 4 },
           css_image: { maximum_allowed: 6, deduction: 3 }
         }
    rule :Gzip,                                      # creates another Rule
         title:     "Compress components with GZip",
         weight:    8,
         deduction: 11
  end
end
