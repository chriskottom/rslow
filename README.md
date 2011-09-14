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


## Sample Code
See the examples folder.


## Architecture / Design Considerations

- Ruleset configuration written in YAML
- Nokogiri for parsing HTML documents
- Net/HTTP for capturing HTTP request and response
Programmatic output will be delivered as JSON.


## Future Enhancements

- Refactoring for more efficient processing, better performance
- More out-of-box rules
- Packaging as a gem
- Create a simple interactive command-line client
- JSON interface


## References
<http://developer.yahoo.com/performance/rules.html>  
<http://developer.yahoo.com/yslow/help/>  
<http://code.google.com/speed/page-speed/>





