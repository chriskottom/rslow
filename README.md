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


### Building the Resource Tree
TBD


### Evaluation
TBD


## Sample Code
Try running the example program.  At present, it implements and configures a
simple ruleset with only a single rule, but it demonstrates the basic flow
described above and the method of configuration of rule and scoring parameters.

```ruby
./examples/simple_test.rb ./examples/simple_ruleset.yml <YOUR_URL_HERE>
```


## Future Enhancements

- Tests
- Refactoring for more efficient processing, better performance
- More out-of-box rules
- Packaging as a gem
- Create a simple interactive command-line client
- JSON output


## References
<http://developer.yahoo.com/performance/rules.html>  
<http://developer.yahoo.com/yslow/help/>  
<http://code.google.com/speed/page-speed/>





