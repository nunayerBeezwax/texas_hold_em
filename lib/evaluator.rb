class Evaluator
	
	def Evaluator.make_best(hand)
		score = 0
		best_hand = { 1 => 'high_card', 2 => 'pair', 3 => 'two_pair', 4 => 'three_of_a_kind',
					  5 => 'straight', 6 => 'flush', 7 => 'full_house', 8 => 'four_of_a_kind',
					  9 => 'straight_flush' }

		best_hand.each do |key, value|

			x = eval("Evaluator.#{value}(hand)")
			if x == true
				score = key
			end
		end
		best_hand[score]
	end

	def Evaluator.high_card(hand)
		hand.sort_by { |card| card.rank }
		true
	end

	def Evaluator.pair(hand)
		x = false
		hand.each do |card|
			if hand.any? { |c| card.rank == c.rank && card != c }
				x = true
			end
		end
		x
	end

	def Evaluator.two_pair(hand)
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

	def Evaluator.three_of_a_kind(hand)
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

	def Evaluator.straight(hand)
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

	def Evaluator.flush(hand)
		suits = %w{ H S C D }
		x = false
		suits.each do |s|
			x = true if hand.count { |card| card.suit == s } >= 5
		end
		x
	end

	def Evaluator.full_house(hand)
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

	def Evaluator.four_of_a_kind(hand)
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

	def Evaluator.straight_flush(hand)
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

