# ESPN stat scraping for nfl

init.rb file runs the code directly from the command line. Just run `ruby init.rb` from the root of the directory and the script should proceed to grab and save the HTML pages, and then parse those pages and save the stats to csv. 


There might be some trouble running the `write_to_csv` method if the csv directories do not already exist. (Of course cloning or forking this repo directly will have all the csv files and directories) 