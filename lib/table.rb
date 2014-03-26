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

	# Left it here, working on showdown.  The problem is... by the time we run make_best on a hand
	# the ranks of the cards are all strings instead of integers so many of the hand check methods
	# don't work.  I don't know at what point/why they become stringed...

	def showdown
		@hands = []
		winner = []
		@table.each do |player|
			@hands << player.combine(@board)
		end
		@hands.each do |hand, player|
			binding.pry
			winner << "#{Table.make_best(hand.hand)} + " " + #{hand.player}"
		end
		puts winner
	end

	def Table.make_best(hand)
		score = 1
		best_hand = { 1 => 'high_card', 2 => 'pair', 3 => 'two_pair', 4 => 'three_of_a_kind',
					  5 => 'straight', 6 => 'flush', 7 => 'full_house', 8 => 'four_of_a_kind',
					  9 => 'straight_flush' }
		best_hand.each do |key, value|
			x = eval("#{value}(hand)")
			if x == true
				score = key
			end
		end
		best_hand[score]
	end

	def Table.high_card(hand)
		hand.sort_by! { |card| card.rank }
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

	def Table.two_pair(hand)
		pairs = 0
		x = false 
		i = 2
		until i == 14
			if hand.count { |card| card.rank == i } == 2
				pairs += 1
				i += 1
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
				i += 1
			end
			i += 1
		end
		if trips >= 1
			x = true
		end
		x
	end
	
	def Table.straight(hand)
		x = false
		i = -1
		until (i-4).abs > hand.uniq{|c| c.rank}.length do
			if (hand.uniq{|c| c.rank}[i].rank - hand.uniq{|c| c.rank}[i -4].rank).abs == 4
				x = true
			end
		i -= 1
		end
		x
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
				i += 1
			end
			if hand.count { |card| card.rank == i } == 2
				pairs += 1
				i += 1
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
				i += 1
			end
			i += 1
		end
		if quads == 1
			x = true
		end
		x
	end

	def Table.straight_flush(hand)
		x = false
		i = -1
		until (i-4).abs > hand.uniq{|c| c.rank}.length do
			if (hand.uniq{|c| c.rank}[i].rank - hand.uniq{|c| c.rank}[i -4].rank).abs == 4
				x = true
			end
		i -= 1
		end
		if hand.count { |card| card.suit } == 5
			x = true
		end
		x
	end
end