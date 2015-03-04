require 'rubygems'
require 'nokogiri'
require 'fileutils'
require 'csv'

class Stats
  attr_accessor :position, :year, :listings
  def initialize(position, year, listings=15)
     @position = position
     @year     = year
     @listings = listings
  end 

  # Helper functions

  def print_header
    puts "*****************************************************"
    puts "**** Printing stats for #{@position} in #{@year} ****"
    puts "*****************************************************"
    CSV.foreach("./csv_hold/clean/#{@year}_#{@position}.csv") do |row|
      if row[0].match("PLAYER")
        row.each_with_index do |item, idx|
          if idx == 0
            print "#{item}" + " "*(30 - item.length)
          elsif idx < row.length - 1
            print "#{item}\t"
          elsif idx == row.length - 1
            print "#{item}\n"
          end
        end
      end
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

  ### Main Functions

  def display_all
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
  end

  def display_stat_gt(stat, number)
    print_header
    CSV.foreach("./csv_hold/clean/#{@year}_#{@position}.csv") do |row|
      if row[3].to_i > number
        row.each_with_index do |item, idx|
          print_nice_rows(row, item, idx)
        end
      end
    end
  end


end # End of stats class