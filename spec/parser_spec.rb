require 'parser'

describe Parser do
  describe '#new' do 
    it 'will initialize with the right position' do  
      p = Parser.new
      expect { p.position.to eq('passing') }
    end
  end
end