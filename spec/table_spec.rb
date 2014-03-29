require 'spec_helper'

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
			test_game = Game.new
			test_game.dealer.preflop
			test_game.dealer.flop
			test_game.dealer.turn
			test_game.dealer.river
			test_game.table.showdown
			test_game.table.showdown.length.should eq 9
		end
	end
end