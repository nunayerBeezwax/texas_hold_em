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
			winner << "Player #{hand.player}: #{Table.make_best(hand.hand)}"
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

	def Table.make_best(hand)
		score = 0
		best_hand = { 1 => 'high_card', 2 => 'pair', 3 => 'two_pair', 4 => 'three_of_a_kind',
					  5 => 'straight', 6 => 'flush', 7 => 'full_house', 8 => 'four_of_a_kind',
					  9 => 'straight_flush' }

		best_hand.each do |key, value|

			x = eval("Table.#{value}(hand)")
			if x == true
				score = key
			end
		end
		best_hand[score]
	end

	def Table.high_card(hand)
		hand.sort_by { |card| card.rank }
		true
	end

	def Table.pair(hand)
		x = false
		hand.each do |card|
			if hand.any? { |c| card.rank == c.rank && card != c }
				x = true
			end
		end
		x
	end

	def Table.two_pair(hand)
		pairs = 0
		x = false
		i = 2
		until i == 14
			if hand.count { |card| card.rank == i } == 2
				pairs += 1
			end
			i += 1
		end
		if pairs >= 2
			x = true
		end
		x
	end

	def Table.three_of_a_kind(hand)
		trips = 0
		x = false
		i = 2
		until i == 14
			if hand.count { |card| card.rank == i } == 3
				trips += 1
			end
			i += 1
		end
		if trips >= 1
			x = true
		end
		x
	end

	def Table.straight(hand)
		temp_hand = hand.clone
		temp_hand.sort_by! { |card| card.rank }
		temp_hand.uniq! { |card| card.rank }
		if temp_hand.length == 5
			if (temp_hand[0].rank - temp_hand[4].rank).abs == 4
				return true
			end
		elsif temp_hand.length == 6
			if (temp_hand[1].rank - temp_hand[5].rank).abs == 4
				return true
			end
		elsif temp_hand.length == 7
			if (temp_hand[2].rank - temp_hand[6].rank).abs == 4
				return true
			end
		end
		false
	end

	def Table.flush(hand)
		suits = %w{ H S C D }
		x = false
		suits.each do |s|
			x = true if hand.count { |card| card.suit == s } >= 5
		end
		x
	end

	def Table.full_house(hand)
		trips = 0
		pairs = 0
		x = false
		i = 2
		until i == 14
			if hand.count { |card| card.rank == i } == 3
				trips += 1
			end
			if hand.count { |card| card.rank == i } == 2
				pairs += 1
			end
			i += 1
		end
		if trips >= 1 && pairs >= 1
			x = true
		end
		x
	end

	def Table.four_of_a_kind(hand)
		quads = 0
		x = false
		i = 2
		until i == 14
			if hand.count { |card| card.rank == i } == 4
				quads += 1
			end
			i += 1
		end
		if quads == 1
			x = true
		end
		x
	end

	def Table.straight_flush(hand)
		straight = false
		temp_hand = hand.clone
		temp_hand.sort_by! { |card| card.rank }
		temp_hand.uniq! { |card| card.rank }
		if temp_hand.length == 5
			if (temp_hand[0].rank - temp_hand[4].rank).abs == 4
				straight = true
			end
		elsif temp_hand.length == 6
			if (temp_hand[1].rank - temp_hand[5].rank).abs == 4
				straight = true
			end
		elsif temp_hand.length == 7
			if (temp_hand[2].rank - temp_hand[6].rank).abs == 4
				straight = true
			end
		end
		if straight == true 
			if temp_hand.count { |card| card.suit } == 5
				return true
			end
		end
	false
	end
end
