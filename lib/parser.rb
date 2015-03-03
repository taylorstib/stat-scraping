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
      else
        break
      end
    end
    puts "=== #open_pages ran ===\n\n"
  end

  # Makes sure the row_length variable is set to the proper number so the page can be parsed
  # correctly for each position
  def row_length
    case @position
    when 'passing'
      @row_length = 14
    when 'rushing'
      @row_length = 12
    when 'receiving'
      @row_length = 14
    end
    STDERR.puts "=== #row_length ran ===\n\n"
  end

  def write_to_csv
    CSV.open("./csv_hold/#{@year}/#{@position}.csv", 'w') do |csv|
      @pages.each do |page|
        arr = []
        page.css('#my-players-table td').each_with_index do |el, i|
          if i == page.css('#my-players-table td').length - 1
            arr.push(el.content)
            csv << arr
          elsif i == 0
            arr.push(el.content)
          elsif (i % @row_length) == 0
            csv << arr
            arr = []
            arr.push(el.content)
          elsif ((i % @row_length) == 1) && (el.content.length > 4)
            name = el.content.split("\n")
            name.delete_at(0) if name.length > 1
            name_array = name[0].split("\n")
            arr.push(name_array.join(' '))
            arr.push(name[1].strip) unless name[1].nil?
          else
            arr.push(el.content)
          end
        end
      end
    end
    STDERR.puts "=== #write_to_csv ran ===\n\n"
  end

  # Deletes the first column for ranking. Unnecessary in the final product
  def delete_rank
    row_length
    row_array = []
    CSV.open("./csv_hold/#{@year}/#{@position}_clean.csv", 'w') do |csv| 
      CSV.foreach("./csv_hold/#{@year}/#{@position}.csv") do |row|
        row.each_with_index do |itm, i|
          if i == @row_length - 1
            row_array.push(itm)
            csv << row_array
            row_array = []
          elsif i > 0
            row_array.push(itm)
          elsif i == 0
          end
        end
      end
    end
      STDERR.puts "=== #delete_rank ran ===\n\n"
  end

  # Deletes the extra header labels that originally appear every 10 rows
  def delete_extra_headers
    count = 0
    CSV.open("./csv_hold/clean/#{@year}_#{@position}.csv", "w") do |csv|
      CSV.foreach("./csv_hold/#{@year}/#{@position}_clean.csv") do |row|
        if ((row[0] == "PLAYER") && (count > 0))
          #puts "#{row} ==> should delete #{count}"
          count = count + 1
        elsif row[0] == "PLAYER"
          count += 1
          csv << row
          # puts "#{row}"
        else
          csv << row
          # puts "#{row}"
        end
      end
    end

    STDERR.puts "=== #delete_extra_headers ran ===\n\n"
  end

end  # End of Parser class
