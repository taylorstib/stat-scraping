require 'scraper'

describe Scraper do
  context 'Initialized without a position' do
    it "has a blank position" do
      x = Scraper.new
      expect(x.position).to eq('')
    end
  end

  context 'Initialized with passing position' do
    it 'position equals passing' do
      y = Scraper.new('passing')
      expect(y.position).to eq('passing')
    end
  end

  context 'Initialized with rushing position' do
    it 'position equals rushing' do
      y = Scraper.new('rushing')
      expect(y.position).to eq('rushing')
    end
  end

  context 'Initialized with invalid position value' do
    it "will raise an error with valid position values" 
  end

end