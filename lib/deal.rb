class Deal

	attr_reader :deck, :table

	def initialize
		@deck = Deck.new
		@deck.deck.shuffle!
		@table = Table.new(9)	
	end

	def preflop
		i = 0
		until @table.table[8].hole_cards.length == 2
			@table.table.each do |player|
				card = @deck.deck.shift
				player.get_card(card)
				i += 1
			end
		end
	end

	def flop
		3.times do 
			card = @deck.deck.shift 
			@table.community_cards(card) 
		end
	end

	def turn
		card = @deck.deck.shift
		@table.community_cards(card)
	end

	def river
		card = @deck.deck.shift
		@table.community_cards(card)
	end

	def Deal.clear
		@deck = []
	end
end