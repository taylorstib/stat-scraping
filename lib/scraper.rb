require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'
require_relative './count_gen.rb'


# Scrapes the web using Nokogiri, saves the webpages as a local variable,
# then writes all the pages to html files locally, for further analysis and parsing
# of the stats 
class Scraper
  include CountGen
  # HTML files get pushed to this array before being written to local storage
  attr_accessor :pages
  # Number of pages for the given position
  attr_accessor :page_quantity
  # The primary year in which your desired season was played 
  attr_accessor :year
  # All pages after the first have a common pattern and this variable encompasses that for each 
  # position  
  attr_accessor :base_dir
  # The player position for which you desire stats
  attr_accessor :position
  # Common pattern for all the positions and years
  attr_accessor :base_url
  # First stat page has a different URL pattern
  attr_accessor :first_page_url
  attr_accessor :array_of_count

# Initialize the Scraper class with the position and year you want stats for. Options
# include 'passing', 'rushing', and 'receiving'.
  def initialize(position='receiving', year='2013')
  # The first page always has a unique URL structure
    @first_page_url = "http://espn.go.com/nfl/statistics/player/_/stat/#{position}/year/#{year}/qualified/false"
    @array_of_count = []
    @pages = []
    @page_quantity = ''
    @year = year.to_s
    @base_dir = { passing: "passing/sort/passingYards/year/#{year}/qualified/false/count/",
                 rushing: "rushing/sort/rushingYards/year/#{year}/qualified/false/count/",
                 receiving: "receiving/sort/receivingYards/year/#{year}/qualified/false/count/"
              }
    @position = position.to_s
    # Common URL structure 
    @base_url = 'http://espn.go.com/nfl/statistics/player/_/stat/'
    generate_count()
    STDERR.puts "New Scraper initiated with #{@year} and #{@position}"
  end


# Nokogiri grabs the HTML, parsing it to determine how many pages need
# to be scraped for the given position, then pushes all the corresponding pages 
# to @pages array so that write_to_file can be called
  def get_html_page
      STDERR.puts "Finding page 1"
      @pages.push(Nokogiri::HTML(open(@first_page_url)))
      STDERR.puts "Page 1 Added"
      results_div = @pages[0].css('#my-players-table div.totalResults').first.content
      number_results_arr = results_div.split(' ')
      number_results = number_results_arr[0].to_i
      ## Output number of players in results
      STDERR.puts "number_results = #{number_results}"
      sleep 2
      if number_results % 40 == 0
        @page_quantity = number_results/40
      else
        @page_quantity = (number_results/40) + 1
      end
      ## Test for number of pages to grab
      STDERR.puts "Page_quantity = #{@page_quantity}"

      if @page_quantity > 1
        @array_of_count[1..(@page_quantity - 1)].each do |n|
          STDERR.puts "== Finding page #{n + 1}"
          @pages.push(Nokogiri::HTML(open(@base_url + "#{@base_dir[@position.to_sym]}" + "#{n}")))
          STDERR.puts "== Page #{n + 1} added\n"
          # Reduce load on server
          sleep rand(8)
        end
      end
  end

# Takes the array @pages and writes each entry to a new file for holding and future data parsing
  def write_to_file
    unless Dir.exist?("./html_hold/#{@year}")
      Dir.mkdir("./html_hold/#{@year}")
    end

    @pages.each_with_index do |page, i|
      STDERR.puts "Writing page #{i + 1}"
      File.open("./html_hold/#{@year}/#{@position}_#{i}.html", 'w') { |f| f.write(page) }
    end
    STDERR.puts "End of write to pages method"
  end
# private
# # Generates an array of numbers, counting by how many player records
# # are on each HTML page. Allows other methods to paginate through the 
# # stat pages and collect them all.
#   def generate_count(step_size=40)
#     counts = (1..921).step(step_size) { |i| @array_of_count.push(i) }
#     @array_of_count
#   end
end
