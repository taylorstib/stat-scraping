#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'

BASE_URL = 'http://espn.go.com/nfl/statistics/player/_/stat/'
BASE_DIR = {:passing => 'passing/sort/passingYards/year/2013/seasontype/2/qualified/false/count/',
            :rushing => 'rushing/sort/rushingYards/year/2013/seasontype/2/qualified/false/count/',
            :receiving => 'receiving/sort/receivingYards/year/2013/seasontype/2/qualified/false/count/',
          }

def scrape(position)
  puts "You asked for the #{position} stats\nHere they come."
  arr = []
  counts = (1..900).step(40) { |i| arr.push(i) }
  
  page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[position.to_sym] + '1'))
  ## Debugging
  puts "Found '#{page.title}'"
  #### Writes the first file ####
  File.open("espn_html_pages/#{position}1.html", 'w'){|f| f.write(page.to_html)}
  puts "First #{position} file saved successfully"

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
        page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[position.to_sym] + "#{x}"))
        #### Writes page to an HTML file on disk ####
        File.open("espn_html_pages/#{position}#{x}.html", 'w'){|f| f.write(page.to_html)}
        puts "File #{position}#{x} saved successfully"
    end
  end
  puts "Reached the end of the 'scrape #{position}' method"

end

scrape('passing')