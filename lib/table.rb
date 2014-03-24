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
		@table.each do |player|
			@hands << player.combine(@board)
		end
		# @hands.each do |hand|
		# 	make_best(hand)
		# end
	end



	

	# def make_best(hand)
	# 	score = 0
	# 	best_hand = { 1 => 'high_card', 2 => 'pair', 3 => 'two_pair', 4 => 'three_of_a_kind'
	# 				  5 => 'straight', 6 => 'flush', 7 => 'full_house', 8 => 'four_of_a_kind'
	# 				  9 => 'straight flush' }
	# 	best_hand.each do |key, value|
	# 		x = eval("#{value}(#{hand})")
	# 		if x == true
	# 			score == key
	# 		end
	# 	end
	# end

	def Table.flush(hand)
		suits = %w{ H S C D }
		x = false
		suits.each do |s|
			x = true if (hand.select { |card| card.suit == s } ).length >= 5
		end
		x
	end

	def Table.straight(hand)
		x = false
		hand.sort_by! { |card| card.rank }
		until hand.length < 5 do
			if (hand[-1].rank - hand[-1 -4].rank).abs == 4
				x = true
			end
		hand.pop
		end
		x
	end

	def Table.pair(hand)
		x = false
		hand.each do |card|
			if hand.any? { |c| card.rank == c.rank }
				x = true
			end
		end
		x
	end

	#working on two pair... one pair ignores 2 pair and 3 of a kind
	#hypothesis is if you find one pair, delete those two and run  again
	def Table.two_pair(hand)
		pairs = 0
		until #something hand.each do |card|
			if hand.any? { |c| card.rank == c.rank }
				pairs += 1
				hand.delete(c)
				hand.delete(card)
				Table.two_pair(hand)
			end
		end
		x
	end
end