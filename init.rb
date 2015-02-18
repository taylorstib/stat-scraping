require_relative './lib/scraper.rb'

years = (2002..2014)
years.each_with_index do |yr, i|
  rush = Scraper.new('rushing', yr)
  pass = Scraper.new('passing', yr)
  rec = Scraper.new('receiving', yr)
  
  ## Run the methods to grab the pages
  rush.get_html_page
  rush.write_to_file
  pass.get_html_page
  pass.write_to_file
  rec.get_html_page
  rec.write_to_file
end
