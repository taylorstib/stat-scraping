require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'

# This URL defines the 'trunk' of all the NFL stat pages. 
BASE_URL = 'http://espn.go.com/nfl/statistics/player/_/stat/'
# Each position has a slightly different URL structure and they are bound to change since this is not
# a robust API
BASE_DIR = { passing: 'passing/sort/passingYards/year/2013/seasontype/2/qualified/false/count/',
             rushing: 'rushing/sort/rushingYards/year/2013/seasontype/2/qualified/false/count/',
             receiving: 'receiving/sort/receivingYards/year/2013/seasontype/2/qualified/false/count/'
          }

# This class scrapes ESPN using Nokogiri for further parsing
# of the stats 
class Scraper
  attr_accessor :position, :array_of_count, :pages, :page_quantity

# Initialize the Scraper class with the position you want stats for. Options
# include 'passing', 'rushing', and 'receiving'.
  def initialize(position)
    if BASE_DIR.keys.include?(position.to_sym)
      @position = position
    else
      raise RuntimeError, "Must be appropriate position (passing, rushing or receiving)"
    end
    @array_of_count = []
    @pages = []
  end

# Generates an array of numbers, counting by how many player records
# are on each HTML page. Allows other methods to paginate through the 
# stat pages and collect them all.
  def generate_count
    counts = (1..921).step(40) { |i| @array_of_count.push(i) }
    @array_of_count
  end

# Access the URL and Nokogiri grabs the HTML, parsing it to determine how many pages need
# to be scraped for the given position
  def get_html_page
    @pages.push(Nokogiri::HTML(open(BASE_URL + BASE_DIR[position.to_sym] + '1')))
    
    results_div = @pages[0].css('#my-players-table div.totalResults').first.content
    number_results_arr = results_div.split(' ')
    number_results = number_results_arr[0].to_i

    if number_results % 40 == 0
      @page_quantity = number_results/40
    else
      @page_quantity = (number_results/40) + 1
    end

    if @page_quantity > 1
      @array_of_count[1..(@page_quantity - 1)].each do |n|
        STDERR.puts "Finding page #{n + 1}"
        @pages.push(Nokogiri::HTML(open(BASE_URL + BASE_DIR[position.to_sym] + "#{n}")))
        STDERR.puts "Page #{n + 1} added\n"
        sleep 2  ## reduce load on server
      end
    end
  end

  def write_to_file
    unless Dir.exists?('./html_hold/')
      Dir.mkdir('./html_hold/')
    end

    @pages.each_with_index do |page, i|
      STDERR.puts "Writing page #{i + 1}"
      File.open("./html_hold/#{position}_#{i}.html", 'w') { |f| f.write(page.to_html) }
      STDERR.puts "Files in the directory now are:"
    end
  end
end