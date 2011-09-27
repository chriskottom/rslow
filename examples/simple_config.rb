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
    rule :DomElements,                               # creates yet another Rule
         title:             "Reduce the number of DOM elements",
         weight:            3,
         max_allowed_nodes: 900,
         range:             250,
         points_per_range:  10
  end
end
