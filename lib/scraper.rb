require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'


BASE_URL = 'http://espn.go.com/nfl/statistics/player/_/stat/'
BASE_DIR = {:passing => 'passing/sort/passingYards/year/2013/seasontype/2/qualified/false/count/',
            :rushing => 'rushing/sort/rushingYards/year/2013/seasontype/2/qualified/false/count/',
            :receiving => 'receiving/sort/receivingYards/year/2013/seasontype/2/qualified/false/count/',
          }

class Scraper
  attr_accessor :position

  def initialize(position='')
    if ## finish this statement
    @position = position
  end

  def scrape
    arr = []
    counts = (1..900).step(40) { |i| arr.push(i) }
  end


end