require 'rubygems'
require 'nokogiri'
require 'fileutils'
require 'csv'

class Stats
  attr_accessor :position, :year, :listings, :headers, :header_hash
  def initialize(position, year, listings=15)
     @position = position
     @year     = year
     @listings = listings
     @headers  = []
     @header_hash = {}
  end 

  ##########################
  #### Helper Functions ####
  ##########################

  def get_headers
    count = 0
    CSV.foreach("./csv_hold/clean/#{@year}_#{@position}.csv") do |row|
      if count == 0
        row.each_with_index do |item, idx|
          @headers.push(item)
        end
        count += 1
      else
        break
      end
    end
    @headers.each_with_index do |name, index|
      @header_hash[name] = index
    end
  end

  def print_header
    get_headers unless @headers.any?
    heading = " #{@year} #{@position.capitalize} Stats "
    heading_len = 140 - heading.length
    puts '*'*140
    puts (' '*(heading_len / 2)) + heading + (' '*(heading_len / 2)) + "\n"
    puts '*'*140 + "\n"
    puts "-"*140
    @headers.each_with_index do |item, idx|
      print_nice_rows(@headers, item, idx)
    end
    # Need to make this dynamic for the terminal window currently open
    puts "-"*140
  end

  def print_nice_rows(row, item, idx)
    if idx == 0
      print "#{item}" + " "*(30 - item.length)
    elsif idx < row.length - 1
      print "#{item}\t"
    elsif idx == row.length - 1
      print "#{item}\n"
    end
  end

  def print_ending
    puts "-"*140
  end
  ########################
  #### Main Functions ####
  ########################

  def display_all
    print_header
    CSV.foreach("./csv_hold/clean/#{@year}_#{@position}.csv") do |row|
      row.each_with_index do |item, idx|
        print_nice_rows(row, item, idx)
      end
    end
  end

  def display_player(player)
    print_header
    CSV.foreach("./csv_hold/clean/#{@year}_#{@position}.csv") do |row|
      if row[0].downcase.match(player.downcase)
        row.each_with_index do |item, idx|
          print_nice_rows(row, item, idx)
        end
      end
    end
    print_ending
  end

  def display_per_team(team)
    print_header
    CSV.foreach("./csv_hold/clean/#{@year}_#{@position}.csv") do |row|
      if row[1].downcase.match(team.downcase)
        row.each_with_index do |item, idx|
          print_nice_rows(row, item, idx)
        end
      end
    end
    print_ending
  end

  def display_stat_gt(stat, number)
    print_header
    CSV.foreach("./csv_hold/clean/#{@year}_#{@position}.csv") do |row|
      if row[header_hash[stat]].split(',').join('').to_f > number
        row.each_with_index do |item, idx|
          print_nice_rows(row, item, idx)
        end
      end
    end
    print_ending
  end

# Display only if given stat is less than provided number
  def display_stat_lt(stat, number)
    print_header
    CSV.foreach("./csv_hold/clean/#{@year}_#{@position}.csv") do |row|
      if row[header_hash[stat]].split(',').join('').to_f < number
        row.each_with_index do |item, idx|
          print_nice_rows(row, item, idx)
        end
      end
    end
    print_ending
  end

  # displays the top (n) listings based on most yards [for now]
  def display_listings
    print_header
    count = 0
    CSV.foreach("./csv_hold/clean/#{@year}_#{@position}.csv") do |row|
      if count == 0
        count += 1
      elsif count <= @listings
        row.each_with_index do |item, idx|
          print_nice_rows(row, item, idx)
        end
          count += 1
      else
        break
      end
    end
    print_ending
  end


end # End of stats class