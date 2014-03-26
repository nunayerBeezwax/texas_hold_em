require 'rspec'
require 'deck'
require 'card'
require 'player'
require 'deal'
require 'hand'
require 'table'
require 'pry'

describe 'Deck' do
	describe '#initialize' do
		it 'creates a standard deck of playing cards' do
			test_deck = Deck.new
			test_deck.should be_an_instance_of Deck
			test_deck.deck.length.should eq 52
			test_deck.deck[0].should be_an_instance_of Card
		end
	end	
end

describe 'Card' do
	describe '#initialize' do
		it 'creates a Card object' do
			test_card = Card.new("H", 5)
			test_card.should be_an_instance_of Card
			test_card.suit.should eq "H"
			test_card.rank.should eq 5
		end
	end
end

describe 'Player' do
	describe '#initialize' do
		it 'sets up a new player with a chip stack and an empty hole_cards array' do
			test_player = Player.new(1, 1000)
			test_player.hole_cards.should eq []
			test_player.seat.should eq 1
			test_player.chips.should eq 1000
			test_player.should be_an_instance_of Player
		end
	end
	describe '#combine' do
		it 'combines the hole cards with the community cards into a Hand object attached to that player' do
			test_game = Deal.new
			test_game.preflop
			test_game.flop
			test_game.turn
			test_game.river
			test_game.table.showdown
			test_game.table.hands.length.should eq 9
			test_game.table.hands[3].hand.length.should eq 7
			test_game.table.hands[7].should be_an_instance_of Hand
			test_game.table.hands[5].player.should eq 6
		end
	end
end

describe 'Table' do
	describe '#initialize' do
		it 'sets up a new table instance with X number of players, and an empty array for community cards' do
			test_table = Table.new(9)
			test_table.table.length.should eq 9
			test_table.should be_an_instance_of Table
			test_table.table[0].should be_an_instance_of Player
			test_table.table[2].chips.should eq 1000
			test_table.board.should eq []
		end
	end
	
	describe '#showdown' do
		it 'collects all remaining players hands into an array' do
			test_game = Deal.new
			test_game.preflop
			test_game.flop
			test_game.turn
			test_game.river
			test_game.table.showdown
			test_game.table.showdown.winner.length.should eq 9
		end
	end

	describe '#make_best' do
		it 'receives a hand and returns the best hand type it contains' do
			test_hand = []
			test_hand << Card.new('D', 3)
			test_hand << Card.new('D', 2)
			test_hand << Card.new('D', 5)
			test_hand << Card.new('D', 4)
			test_hand << Card.new('D', 6)
			test_hand << Card.new('C', 5)
			test_hand << Card.new('S', 4)
			Table.make_best(test_hand).should eq 'straight_flush'
		end
	end	

	describe '.flush' do
		it 'returns true if a given hand contains at least 5 of a suit' do
			test_hand = []
			7.times { |i| test_hand << Card.new('S', i + 1) }
			Table.flush(test_hand).should eq true
			test_hand = []
			4.times { |i| test_hand << Card.new('S', i + 1) }
			3.times { |i| test_hand << Card.new('H', i + 1) }
			Table.flush(test_hand).should eq false
		end
	end

	describe '.straight' do
		it 'returns true if a given hand contains any 5 rank in a row' do
			test_hand = []
			junk_hand = []
			junk_hand << Card.new('D', 2)
			junk_hand << Card.new('S', 3)
			junk_hand << Card.new('H', 5)
			junk_hand << Card.new('C', 7)
			junk_hand << Card.new('D', 10)
			junk_hand << Card.new('S', 12)
			junk_hand << Card.new('C', 9)
			7.times { |i| test_hand << Card.new('S', i + 1) }
			Table.straight(test_hand).should eq true
			Table.straight(junk_hand).should eq false
		end
	end

	describe '.pair' do
		it 'returns true if a given hand contains any two cards with same rank' do
			test_hand = []
			test_hand << Card.new('D', 2)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 3)
			test_hand << Card.new('C', 7)
			test_hand << Card.new('D', 10)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Table.pair(test_hand).should eq true
		end
	end

	describe '.two_pair' do
		it 'returns true if a given hand contains any two pairs' do
			test_hand = []
			test_hand << Card.new('D', 2)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 3)
			test_hand << Card.new('C', 7)
			test_hand << Card.new('D', 7)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Table.two_pair(test_hand).should eq true
		end
	end

	describe '.three_of_a_kind' do
		it 'returns true if a given hand has any three cards of same rank' do
			test_hand = []
			test_hand << Card.new('D', 2)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 3)
			test_hand << Card.new('C', 4)
			test_hand << Card.new('D', 7)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Table.three_of_a_kind(test_hand).should eq false
		end
	end

	describe '.full_house' do
		it 'returns true if a given hand has any pair and three cards of same rank' do
			test_hand = []
			test_hand << Card.new('D', 2)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 3)
			test_hand << Card.new('C', 4)
			test_hand << Card.new('D', 4)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('C', 9)
			Table.full_house(test_hand).should eq true
		end
	end

	describe '.four_of_a_kind' do
		it 'returns true if a given hand has any four cards of same rank' do
			test_hand = []
			test_hand << Card.new('D', 3)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 11)
			test_hand << Card.new('C', 3)
			test_hand << Card.new('D', 7)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Table.four_of_a_kind(test_hand).should eq false
		end
	end

	describe '.straight_flush' do
		it 'returns true if a given hand has a straight all in one suit' do
			test_hand = []
			test_hand << Card.new('D', 3)
			test_hand << Card.new('D', 4)
			test_hand << Card.new('D', 9)
			test_hand << Card.new('D', 6)
			test_hand << Card.new('D', 7)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Table.straight_flush(test_hand).should eq false
		end
	end
end

describe 'Deal' do
before do
	Deck.clear
	Deal.clear
end
	describe '#initialize' do
		it 'makes and shuffles a deck from which to deal random cards' do
			test_deal = Deal.new
			test_deal.deck.deck.length.should eq 52
			test_deal.deck.deck[33].should be_an_instance_of Card
		end
	end

	describe '#preflop' do
		it 'removes cards from the deck, dealing 2 cards to each player' do
			test_deal = Deal.new
			test_deal.preflop
			test_deal.table.table[5].hole_cards.length.should eq 2
			test_deal.table.table[8].hole_cards.length.should eq 2
			test_deal.table.table[0].hole_cards.length.should eq 2
			test_deal.deck.deck.length.should eq 34
		end
	end
	
	describe '#flop' do
		it 'removes 3 cards from the deck and displays them as community cards' do
			test_deal = Deal.new
			test_deal.preflop
			test_deal.flop
			test_deal.table.board.length.should eq 3
			test_deal.table.board[1].should be_an_instance_of Card
			test_deal.deck.deck.length.should eq 31
		end
	end

	describe '#turn and #river' do
		it 'each when called adds one more card to the community cards' do
			test_deal = Deal.new
			test_deal.preflop
			test_deal.flop
			test_deal.turn
			test_deal.table.board.length.should eq 4
			test_deal.river
			test_deal.table.board.length.should eq 5
		end
	end
end