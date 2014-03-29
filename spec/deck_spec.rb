require 'spec_helper'

describe 'Deck' do
	before do 
		Deck.clear
	end
	describe '#initialize' do
		it 'creates a standard deck of playing cards' do
			test_deck = Deck.new
			test_deck.should be_an_instance_of Deck
			test_deck.deck.length.should eq 52
			test_deck.deck[0].should be_an_instance_of Card
		end
	end
end
