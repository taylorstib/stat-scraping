# ESPN stat scraping for nfl

### This branch attempts to make all the code DRY
To get stats for season 2005 - 2014, run the **init.rb** file. This will generate local copies of HTML pages for all the stats. 
_Working on getting the stats parsing code DRY-d up._

The spec/ directory contains passing Rspec tests for the Scraper class, which uses Nokogiri to grab the HTML pages for the designated URLs. 
