require_relative './lib/scraper.rb'
require_relative './lib/parser.rb'
require_relative './lib/stats.rb'

years = (2002..2014)

  # methods below are for grabbing the html pages if
  # not in the html_hold directory already
# years.each_with_index do |yr, i|
#   rush = Scraper.new('rushing', yr)
#   pass = Scraper.new('passing', yr)
#   rec = Scraper.new('receiving', yr)
  
#   ## Run the methods to grab the pages
#   rush.get_html_page
#   rush.write_to_file
#   pass.get_html_page
#   pass.write_to_file
#   rec.get_html_page
#   rec.write_to_file
# end
  
  # These methods write the data fields in html page, to a csv file
# years.each_with_index do |yr, i|
#   rush = Parser.new('rushing', yr)
#   pass = Parser.new('passing', yr)
#   rec = Parser.new('receiving', yr)
# ## Run methods once each instance has been instantiated
#   rush.open_pages
#   rush.row_length
#   rush.write_to_csv
#   pass.open_pages
#   pass.row_length
#   pass.write_to_csv
#   rec.open_pages
#   rec.row_length
#   rec.write_to_csv
# end

  # These methods delete the rank column
# years.each_with_index do |yr, i|
#   pass = Parser.new('passing', yr)
#   pass.delete_rank
#   rush = Parser.new('rushing', yr)
#   rush.delete_rank
#   rec = Parser.new('receiving', yr)
#   rec.delete_rank
# end

  # These methods remove the extra headers
# years.each_with_index do |yr, i|
#   pass = Parser.new('passing', yr)
#   rush = Parser.new('rushing', yr)
#   rec = Parser.new('receiving', yr)
#   [pass, rush, rec].each do |position|
#     position.delete_extra_headers
#   end
# end

# years.each_with_index do |yr, i|
  # pass = Parser.new('passing', 2013)
  # rush = Parser.new('rushing', 2013)
  # rec = Parser.new('receiving', 2013)
  # [pass].each do |position|
  #   position.print_stats
  # end
# end

# years.each do |yr|
  # stat = Stats.new('passing', yr)
  # stat = Stats.new('rushing', yr, 5)
  # stat.print_header
  # stat.display_all
  # stat.display_player('Tomlinson')
  # stat.display_per_team('gb')
  # stat.display_stat_gt(1, 450)
  stat2 = Stats.new('rushing', 2009, 5)
  stat2.display_listings
  # stat.get_headers
# end