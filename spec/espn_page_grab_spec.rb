require 'spec_helper.rb'

describe Scraper do
    describe '#scrape' do
      it 'Finds the right ESPN page' do
        expect(Scraper.new.scrape('passing')).to output.to_stderr
      end

      it 'Grabs the corresponding pages'
  end
end
