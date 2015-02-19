require 'rubygems'
require 'nokogiri'
require 'fileutils'
require 'csv'
require_relative './count_gen.rb'

# Object responsible for grabbing the HTML pages out of the local file storage, 
# and extracting the stats to CSV format
class Parser
  include CountGen
  attr_accessor :position, :year, :pages, :array_of_count, :row_length 

  def initialize(position='passing', year='2014')
    @position = position.to_s
    @year = year.to_s
    @pages = []
    @array_of_count = []
  end

  # Checks to see if the file exists, then opens it and appends the file to the @pages variable
  def open_pages
    (0..13).each do |n|
      if File.exist?("./html_hold/#{@year}/#{@position}_#{n}.html")
        page = Nokogiri::HTML(open("./html_hold/#{@year}/#{@position}_#{n}.html"))
        @pages.push(page)
        STDERR.puts "Pushed page #{n}"
      else
        STDERR.puts "BREAKING"
        break
      end
    end
    puts "=== #open_pages ran ===\n\n"
  end

  def row_length
    case @position
    when 'passing'
      @row_length = 14
    when 'rushing'
      @row_length = 12
    when 'receiving'
      @row_length = 14
    end
    STDERR.puts "Row-Length = #{@row_length}"
    STDERR.puts "=== #row_length ran ===\n\n"
  end

  def write_to_csv
    holding_array = []
    arr_of_arrs = []
    CSV.open("./csv_hold/#{@year}/#{@position}.csv", 'w') do |csv|
      @pages.each do |pg|
        pg.css('#my-players-table td').each do |item|
          holding_array.push(item.content)
        end
        until holding_array.length == 0
          arr_of_arrs.push(holding_array.slice!(0..(@row_length-1)))
        end
      end
      arr_of_arrs.flatten!
      csv << arr_of_arrs
    end
    STDERR.puts "=== #write_to_csv ran ===\n\n"
  end

end  # End of Parser class