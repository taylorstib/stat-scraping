require 'scraper'

describe Scraper do
  describe "#new" do 
    context 'Initialized WITHOUT an argument' do
      it "will raise an ArgumentError" do
        expect { x = Scraper.new }.to raise_error(ArgumentError)
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
    context 'Initialized with receiving position' do
      it 'position equals receiving' do
        y = Scraper.new('receiving')
        expect(y.position).to eq('receiving')
      end
    end

    context 'Initialized with invalid position value' do
      it "will raise an error with valid position values" do
        expect { Scraper.new('nonsense')}.to raise_error(RuntimeError)
      end
    end
  end

  describe "#generate_count" do
    it "Generates an array" do
      scraper = Scraper.new('passing')
      expect(scraper.generate_count).to be_an(Array)
    end
    it "Has the right values counting from 1 to 900 by 40's" do 
      scraper = Scraper.new('passing')
      expect(scraper.generate_count).to eq([1, 41, 81, 121, 161, 201, 241, 281, 321, 361, 401, 441, 481, 521, 561, 601, 641, 681, 721, 761, 801, 841, 881, 921])
    end
  end

  describe "#get_html_page" do
    it "Returns a Nokogiri object" do 
      scraper = Scraper.new('passing')
      expect(scraper.get_html_page).to be_a(Nokogiri::HTML::Document)
    end
    it "Finds the right page at specified URL" do 
      scraper = Scraper.new('passing')
      scraper.get_html_page
      expect(scraper.page.title).to include("NFL Player #{scraper.position.capitalize} Stats")
    end
  end
end

