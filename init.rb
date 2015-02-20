require_relative './lib/scraper.rb'
require_relative './lib/parser.rb'

years = (2005..2014)
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
  

years.each_with_index do |yr, i|
  rush = Parser.new('rushing', yr)
  pass = Parser.new('passing', yr)
  rec = Parser.new('receiving', yr)
## Run methods once each instance has been instantiated
  rush.open_pages
  rush.row_length
  rush.write_to_csv
  pass.open_pages
  pass.row_length
  pass.write_to_csv
  rec.open_pages
  rec.row_length
  rec.write_to_csv
end
