require 'rspec'
require 'deck'
require 'card'
require 'player'
require 'deal'
require 'table'
require 'pry'

describe 'Deck' do
	describe 'initialize' do
		it 'creates a standard deck of playing cards' do
			test_deck = Deck.new
			test_deck.should be_an_instance_of Deck
			test_deck.deck.length.should eq 52
			test_deck.deck[0].should be_an_instance_of Card
		end
	end	
end

describe 'Card' do
	describe 'initialize' do
		it 'creates a Card object' do
			test_card = Card.new("H", 5)
			test_card.should be_an_instance_of Card
			test_card.suit.should eq "H"
			test_card.rank.should eq 5
		end
	end
end

describe 'Player' do
	describe 'initialize' do
		it 'sets up a new player with a chip stack and an empty hand array' do
			test_player = Player.new(1000)
			test_player.hand.should eq []
			test_player.chips.should eq 1000
			test_player.should be_an_instance_of Player
		end
	end
end

describe 'Table' do
	describe 'initialize' do
		it 'sets up a new table instance with X number of players' do
			test_table = Table.new(9)
			test_table.table.length.should eq 9
			test_table.should be_an_instance_of Table
			test_table.table[0].should be_an_instance_of Player
			test_table.table[2].chips.should eq 1000
		end
	end
end

describe 'Deal' do
before do
	Deck.clear
	Deal.clear
end
	describe 'initialize' do
		it 'makes and shuffles a deck from which to deal random cards' do
			test_deal = Deal.new
			test_deal.deck.deck.length.should eq 52
			test_deal.deck.deck[33].should be_an_instance_of Card
		end
	end

	describe 'preflop' do
		it 'deals 2 cards to each player' do
			test_deal = Deal.new
			test_deal.preflop
			test_deal.table.table[5].hand.length.should eq 2
			test_deal.table.table[8].hand.length.should eq 2
			test_deal.table.table[0].hand.length.should eq 2
		end
	end
end