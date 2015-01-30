require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'

BASE_URL = 'http://espn.go.com/nfl/statistics/player/_/stat/'
BASE_DIR = {:passing => 'passing/sort/passingYards/year/2013/seasontype/2/qualified/false/count/',
            :rushing => 'rushing/sort/rushingYards/year/2013/seasontype/2/qualified/false/count/',
            :receiving => 'receiving/sort/receivingYards/year/2013/seasontype/2/qualified/false/count/',
          }

def scrape_passing
  arr = []
  counts = (1..900).step(40) { |i| arr.push(i) }
  
  page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:passing] + '1'))
  #### Writes the first file ####
  File.open("espn_html_pages/passing1.html", 'w'){|f| f.write(page.to_html)}
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
    arr[(1..(num_pages-1))].each do |x|
        page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:passing] + "#{x}"))
        #### Writes page to an HTML file on disk ####
        File.open("espn_html_pages/passing#{x}.html", 'w'){|f| f.write(page.to_html)}
        puts "File passing#{x} saved successfully"
    end
  end
  puts "Reached the end of the 'scrape_passing' method"
end

def scrape_rushing
  arr = []
  counts = (1..900).step(40) { |i| arr.push(i) }

  page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:rushing] + '1'))
  #### Writes the first file ####
  File.open("espn_html_pages/rushing1.html", 'w'){|f| f.write(page.to_html)}
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
    arr[(1..(num_pages-1))].each do |x|
        page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:rushing] + "#{x}"))
        #### Writes page to an HTML file on disk ####
        File.open("espn_html_pages/rushing#{x}.html", 'w'){|f| f.write(page.to_html)}
        puts "File rushing#{x} saved successfully"
    end
  end
  puts "Reached the end of the 'scrape_rushing' method"
end

def scrape_receiving
  arr = []
  counts = (1..900).step(40) { |i| arr.push(i) }

  page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:receiving] + '1'))
  #### Writes the first file ####
  File.open("espn_html_pages/receiving1.html", 'w'){|f| f.write(page.to_html)}
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
    arr[(1..(num_pages-1))].each do |x|
        page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[:receiving] + "#{x}"))
        #### Writes page to an HTML file on disk ####
        File.open("espn_html_pages/receiving#{x}.html", 'w'){|f| f.write(page.to_html)}
        puts "File receiving#{x} saved successfully"
    end
  end
  puts "Reached the end of the 'scrape_receiving' method"
end


# scrape_passing
# scrape_rushing
scrape_receiving
