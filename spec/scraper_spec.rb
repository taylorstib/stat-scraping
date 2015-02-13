require 'scraper'

describe Scraper do
  describe "#new" do 
    context 'WITHOUT an argument' do
      it "will raise an ArgumentError" do
        expect { x = Scraper.new }.to raise_error(ArgumentError)
      end
    end

    context 'initialized with passing position' do
      it 'position equals passing' do
        y = Scraper.new('passing')
        expect(y.position).to eq('passing')
      end
    end

    context 'initialized with rushing position' do
      it 'position equals rushing' do
        y = Scraper.new('rushing')
        expect(y.position).to eq('rushing')
      end
    end
    context 'initialized with receiving position' do
      it 'position equals receiving' do
        y = Scraper.new('receiving')
        expect(y.position).to eq('receiving')
      end
    end

    context 'initialized with invalid position value' do
      it "will raise an error, listing valid position values" do
        expect { Scraper.new('nonsense')}.to raise_error(RuntimeError)
      end
    end
  end

  describe "#generate_count" do
    it "Generates an array" do
      scraper = Scraper.new('passing')
      expect(scraper.array_of_count).to be_an(Array)
    end
    it "Has the right values counting from 1 to 900 by 40's" do 
      scraper = Scraper.new('passing')
      expect(scraper.array_of_count).to eq([1, 41, 81, 121, 161, 201, 241, 281,
                                            321, 361, 401, 441, 481, 521, 561,
                                            601, 641, 681, 721, 761, 801, 841, 881, 921])
    end
  end

  # describe "#get_html_page" do
  #     it "Returns a Nokogiri object" do 
  #       scraper = Scraper.new('passing')
  #       scraper.generate_count
  #       scraper.get_html_page
  #       expect(scraper.pages[0]).to be_a(Nokogiri::HTML::Document)
  #     end
  #     it "Finds the right page at specified URL" do 
  #       scraper = Scraper.new('passing')
  #       scraper.generate_count
  #       scraper.get_html_page
  #       expect(scraper.pages[0].title).to include("NFL Player #{scraper.position.capitalize} Stats")
  #     end
    # context 'after finding the appropriate HTML page' do 
    #   it "Determines the right number of passing pages to scrape" do 
    #     scraper = Scraper.new('passing')
    #     scraper.generate_count
    #     scraper.get_html_page
    #     expect(scraper.page_quantity).to eq(3)
    #   end    
    #   it "Determines the right number of rushing pages to scrape" do 
    #     scraper = Scraper.new('rushing')
    #     scraper.generate_count
    #     scraper.get_html_page
    #     expect(scraper.page_quantity).to eq(8)
    #   end
    #   it "Determines the right number of receiving pages to scrape" do 
    #     scraper = Scraper.new('receiving')
    #     scraper.generate_count
    #     scraper.get_html_page
    #     expect(scraper.page_quantity).to eq(12)
    #   end
    # end
  #   context 'after determining how many pages to find' do 
  #     it 'Loops through and adds that amount of pages to @pages array' do 
  #       scraper = Scraper.new('passing')
  #       scraper.generate_count
  #       scraper.get_html_page
  #       expect(scraper.pages.count).to eq(scraper.page_quantity)
  #     end
  #   end
  # end

  # describe "#write_to_file" do 
  #   context 'if no html_hold directory exists' do 
  #     it 'Can detect that such directory is non-existant' do 
  #       expect(Dir.exists?('../html_hold/')).to be(false)
  #     end
  #   end
  #   context 'if the directory already exists' do 
  #     it 'Writes to stderr which file it is writing'
  #     it 'Writes the file to the proper directory'
  #     it 'Moves on to the next file'
  #   end
  # end
end

