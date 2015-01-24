require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'

BASE_URL = 'http://espn.go.com/nfl/statistics/player/_/stat/'
BASE_DIR = {:passing => 'passing/sort/passingYards/seasontype/2/qualified/false/count/',
            :rushing => 'rushing/seasontype/2/qualified/false/count/',
            # :receiving => 'receiving/sort/receivingYards/qualified/false/count/',
            # :kicking => 'kicking/sort/fieldGoalsMade/qualified/false/count/'
          }

def scrape_passing
  counts = [1, 41, 81, 121, 161, 201, 241, 281, 321, 361, 401, 441, 481, 521, 561, 601]
  page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:passing] + '1'))
  #### Writes the first file ####
  File.open("stat_pages/passing1.html", 'w'){|f| f.write(page.to_html)}
  puts "First passing file saved successfully"

  #### Find the number of results(players) for the given stat request ####
  results_div = page.css('#my-players-table div.totalResults').first.content
  number_results_arr = results_div.split(' ')
  number_results = number_results_arr[0].to_i

  #### Finding the correct number of pages to find ####
  if number_results % 40 == 0
    num_pages = number_results/40
  else
    num_pages = (number_results/40) + 1
  end

  puts "#{num_pages - 1} more pages need to be collected"

  if num_pages > 1
    #### Grabs each page of stats for passing ####
    counts[(1..(num_pages-1))].each do |x|
        page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:passing] + "#{x}"))
        #### Writes page to an HTML file on disk ####
        File.open("stat_pages/passing#{x}.html", 'w'){|f| f.write(page.to_html)}
        puts "File passing#{x} saved successfully"
    end
  end
  puts "Reached the end of the 'scrape_passing' method"
end

def scrape_rushing
  counts = [1, 41, 81, 121, 161, 201, 241, 281, 321, 361, 401, 441, 481, 521, 561, 601]
  page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:rushing] + '1'))
  #### Writes the first file ####
  File.open("stat_pages/rushing1.html", 'w'){|f| f.write(page.to_html)}
  puts "First rushing file saved successfully"

  #### Find the number of results(players) for the given stat request ####
  results_div = page.css('#my-players-table div.totalResults').first.content
  number_results_arr = results_div.split(' ')
  number_results = number_results_arr[0].to_i

  #### Finding the correct number of pages to find ####
  if number_results % 40 == 0
    num_pages = number_results/40
  else
    num_pages = (number_results/40) + 1
  end

  puts "#{num_pages - 1} more pages need to be collected"

  if num_pages > 1
    #### Grabs each page of stats for rushing ####
    counts[(1..(num_pages-1))].each do |x|
        page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:rushing] + "#{x}"))
        #### Writes page to an HTML file on disk ####
        File.open("stat_pages/rushing#{x}.html", 'w'){|f| f.write(page.to_html)}
        puts "File rushing#{x} saved successfully"
    end
  end
  puts "Reached the end of the 'scrape_rushing' method"
end

def scrape_receiving
  counts = [1, 41, 81, 121, 161, 201, 241, 281, 321, 361, 401, 441, 481, 521, 561, 601]
  page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:receiving] + '1'))
  #### Writes the first file ####
  File.open("stat_pages/receiving1.html", 'w'){|f| f.write(page.to_html)}
  puts "First Receiving file saved successfully"

  #### Find the number of results(players) for the given stat request ####
  results_div = page.css('#my-players-table div.totalResults').first.content
  number_results_arr = results_div.split(' ')
  number_results = number_results_arr[0].to_i

  #### Finding the correct number of pages to find ####
  if number_results % 40 == 0
    num_pages = number_results/40
  else
    num_pages = (number_results/40) + 1
  end

  puts "#{num_pages - 1} more pages need to be collected"

  if num_pages > 1
    #### Grabs each page of stats for receiving ####
    counts[(1..(num_pages-1))].each do |x|
        page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:receiving] + "#{x}"))
        #### Writes page to an HTML file on disk ####
        File.open("stat_pages/receiving#{x}.html", 'w'){|f| f.write(page.to_html)}
        puts "File receiving#{x} saved successfully"
    end
  end
  puts "Reached the end of the 'scrape_receiving' method"
end


# scrape_passing
scrape_rushing
# scrape_receiving
