# ESPN stat scraping for nfl

### This branch attempts to make all the code DRY
The **scraper.rb** file is more concise, and contains a Scraper class instead of the old, quick-and-dirty script. Next phase of this project is updating the **pull_data*.rb* files so one class can be built, and the options passed into it, instead of a separate file for each position. 

The spec/ directory contains passing Rspec tests for the Scraper class, which uses Nokogiri to grab the HTML pages for the designated URLs. 

Pushing to Travis-ci.org
