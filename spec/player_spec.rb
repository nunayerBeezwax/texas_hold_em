require 'spec_helper'

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
			test_game = Game.new
			test_game.dealer.preflop
			test_game.dealer.flop
			test_game.dealer.turn
			test_game.dealer.river
			test_game.table.showdown
			test_game.table.hands.length.should eq 9
			test_game.table.hands[3].hand.length.should eq 7
			test_game.table.hands[7].should be_an_instance_of Hand
			test_game.table.hands[5].player.should eq 6
		end
	end
end