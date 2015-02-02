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
  attr_accessor :position, :arr, :page

  def initialize(position)
    if BASE_DIR.keys.include?(position.to_sym)
      @position = position
    else
      raise RuntimeError, "Must be appropriate position (passing, rushing or receiving)"
    end
    @array_of_count = []
    @page = ''
  end

  def generate_count
    counts = (1..921).step(40) { |i| @array_of_count.push(i) }
    @array_of_count
  end

  def get_html_page
    @page = Nokogiri::HTML(open(BASE_URL + BASE_DIR[position.to_sym] + '1'))
  end
end