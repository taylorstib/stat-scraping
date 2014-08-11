require 'rubygems'
require 'nokogiri'
require 'fileutils'
require 'csv'

#### scrapes page for all players listed, comma separated ####
###########################################
####    rushing page has 12 columns    ####
#### Last one is the array[11] element ####
###########################################

page = Nokogiri::HTML(open('stat_pages/rushing1.html'))

CSV.open('data_hold/rushing1.csv', 'w') do |csv|
  arr = []
  puts page.css('#my-players-table td').length  #### just tells how many table data cells there are 

# #### Lists the first 40 players #### 
  page.css('#my-players-table td').each_with_index do |el, i|
    if i == page.css('#my-players-table td').length - 1
      arr.push(el.content)
      csv << arr
    elsif i == 0
      arr.push(el.content)
    elsif (i % 12) == 0
      csv << arr
      arr = []
      arr.push(el.content)
    elsif ((i % 12) == 1) && (el.content.length > 4)
      name = el.content.split("\n")
      name.delete_at(0) if name.length > 1
      name_arr = name[0].split("\n")
      arr.push(name_arr.join(' '))
      arr.push(name[1].strip) unless name[1].nil?
    else
      arr.push(el.content)
    end
  end
end

page2 = Nokogiri::HTML(open('stat_pages/rushing41.html'))

CSV.open('data_hold/rushing1.csv', 'a+') do |csv|
arr = []
#### Lists the next 41-80 players #### 
  page2.css('#my-players-table td').each_with_index do |el, i|
    if i == page2.css('#my-players-table td').length - 1
      arr.push(el.content)
      csv << arr
    elsif i == 0
      arr.push(el.content)
    elsif (i % 12) == 0
      csv << arr
      arr = []
      arr.push(el.content)
    elsif ((i % 12) == 1) && (el.content.length > 4)
      name = el.content.split("\n")
      name.delete_at(0) if name.length > 1
      name_arr = name[0].split("\n")
      arr.push(name_arr.join(' '))
      arr.push(name[1].strip) unless name[1].nil?
    else
      arr.push(el.content)
    end
  end
end

page3 = Nokogiri::HTML(open('stat_pages/rushing81.html'))

CSV.open('data_hold/rushing1.csv', 'a+') do |csv|
arr = []
#### Lists the next 81-120 players #### 
  page3.css('#my-players-table td').each_with_index do |el, i|
    if i == page3.css('#my-players-table td').length - 1
      arr.push(el.content)
      csv << arr
    elsif i == 0
      arr.push(el.content)
    elsif (i % 12) == 0
      csv << arr
      arr = []
      arr.push(el.content)
    elsif ((i % 12) == 1) && (el.content.length > 4)
      name = el.content.split("\n")
      name.delete_at(0) if name.length > 1
      name_arr = name[0].split("\n")
      arr.push(name_arr.join(' '))
      arr.push(name[1].strip) unless name[1].nil?
    else
      arr.push(el.content)
    end
  end
end

page4 = Nokogiri::HTML(open('stat_pages/rushing121.html'))

CSV.open('data_hold/rushing1.csv', 'a+') do |csv|
arr = []
#### Lists the next 121-160 players #### 
  page4.css('#my-players-table td').each_with_index do |el, i|
    if i == page4.css('#my-players-table td').length - 1
      arr.push(el.content)
      csv << arr
    elsif i == 0
      arr.push(el.content)
    elsif (i % 12) == 0
      csv << arr
      arr = []
      arr.push(el.content)
    elsif ((i % 12) == 1) && (el.content.length > 4)
      name = el.content.split("\n")
      name.delete_at(0) if name.length > 1
      name_arr = name[0].split("\n")
      arr.push(name_arr.join(' '))
      arr.push(name[1].strip) unless name[1].nil?
    else
      arr.push(el.content)
    end
  end
end