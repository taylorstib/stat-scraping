require_relative './lib/scraper.rb'
require_relative './lib/parser.rb'

# years = (2002..2014)
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
  

# rush = Scraper.new('rushing', '2014')
# puts rush.array_of_count
par = Parser.new
par.open_pages
par.row_length
par.write_to_csv
blah = Parser.new('receiving')
blah.open_pages
blah.row_length
blah.write_to_csv
