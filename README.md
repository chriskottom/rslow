# RSlow: a website performance testing engine


## Concept
A tool for evaluating web page optimization and performance a la YSlow, 
PageSpeed, etc.


## Background
There are many tools available, either online or as browser plug-ins, that 
will tell you whether or not your page/site conforms to best practices, but as 
far as I know, there aren't a ton of libraries or utilities that you could drop 
into an existing system in order to perform evaluations programmatically.  This
tool is intended to provide a framework for defining and executing a 
configurable set of rules that will gauge or grade probable end user experience 
based on critieria like HTTP request and response parameters, page structure, 
number and size of requested resources, etc.


## Architecture / Design Considerations
The general method of evaluating a web page will involve two distinct processing
steps: building the resource tree and evaluation.


### The Resource Tree
The domain model for this tool is the DOM of the target web page.  This is
represented in the application as a tree of linked objects which store 
information about the requests and responses for the various resources
comprising the page.


### Rules and Rulesets
Rules within the framework evaluate the tree of resources in order to determine
how well a page will conform to a given best practice.  Based on this evaluation
the `Rule` object will calculate a score out of a possible 100 points and assign
a letter grade A-F.  Most of the logic for evaluation is contained in the `Rule`
class whereas concrete implementations will define how deductions from the
maximum possible score should be calculated for a given resource tree by
defining the `#compute_deductions` method.

Rulesets are defined using a simple Ruby DSL syntax and identify a set of rules
that should be calculated for a resource tree as well as the relative numeric
weights that should be given to each rule.  For example:

```ruby
RSlow.configure do
  ruleset :simple_ruleset do                         # creates a Ruleset
    rule :RequestCount,                              # creates a Rule
         title:             "Minimize HTTP requests",
         weight:            8,
         resources: {
           script:    { maximum_allowed: 3, deduction: 3 },
           css:       { maximum_allowed: 2, deduction: 4 },
           css_image: { maximum_allowed: 6, deduction: 3 }
         }
    rule :Gzip,                                      # creates another Rule
         title:             "Compress components with GZip",
         weight:            8,
         deduction:         11
```

Ruleset evaluations are returned as strings containing JSON-formatted text.


## Sample Code
Try running the example program.  At present, it implements and configures a
simple ruleset with a few basic rules, but it demonstrates the basic flow
described above and the method of configuration of rule and scoring parameters.

```ruby
./examples/simple_test.rb < YOUR URL >
```


## Future Enhancements
- Performance improvements - creating fewer objects, lazy tree node creation,
  only making HEAD requests for resources that won't be parsed
- Create a simple interactive command-line client
- Gem packaging
- More out-of-box rules


## References
- Yahoo! YSlow
  - [Best Practices for Speeding Up Your Web Site](http://developer.yahoo.com/performance/rules.html)
  - [YSlow User Guide](http://developer.yahoo.com/yslow/help/)
  - [Ruleset Matrix](http://developer.yahoo.com/yslow/matrix/)
- Google Page Speed
  - [Official Google Homepage](http://code.google.com/speed/page-speed/)





