# ESPN stat scraping for nfl
Scrape.rb grabs the HTML pages and stores them in the stat_pages directory.
The pull data .rb files parse the HTML files, appending the data into CSV format. The CSV files are then found in data_hold directory. 

```
$ ruby scrape.rb

$ ruby pull_data_passing.rb
$ ruby pull_data_rushing.rb
$ ruby pull_data_receiving.rb

```
#### As of right now, there will be extra heading rows every 10 csv rows as a result of the literal parsing of the HTML tables.


### Work in progress
---
- Want to make it a single pull_data script (check issues for specifics)
- Turn it into a gem
  - (Currently in development)
- Have the data hold pages labeled for the given season and week number
- Ability to scrape past seasons??
  - (this will be implemented for the CLI tool being built)
