class Table

	attr_reader :table, :board, :hands

	def initialize(num_of_players)
		@table = []
		@board = []
		@hands = []
		num_of_players.times { @table << Player.new(@table.length+1, 1000) }
	end

	def community_cards(card)
		@board << card
	end

	def showdown
		@hands = []
		winner = []
		@table.each do |player|
			@hands << player.combine(@board)
		end
		@hands.each do |hand, player|
			winner << "Player #{hand.player}: #{Evaluator.make_best(hand.hand)}"
		end
		@table.each do |player|
			puts "---------"
			player.hole_cards.each do |card|
				puts "#{player.seat}: #{card.rank} #{card.suit}"
			end
		end
		@board.each do |card|
			puts "#{card.rank} #{card.suit}"
		end
		puts winner
		return winner
	end
end