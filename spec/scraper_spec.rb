require 'scraper'

describe Scraper do
  describe "#new" do 
    context 'Initialized without a position' do
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
    it "Has the right values counting from 1 to 900 by 40's"   
  end

end

