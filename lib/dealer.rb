class Dealer

	attr_reader :deck, :table

	def initialize(table)
		@deck = Deck.new
		@deck.shuffle
		@table = table
	end

	def preflop
		i = 0
		until @table.table[8].hole_cards.length == 2
			@table.table.each do |player|
				card = @deck.give_card
				player.get_card(card)
				i += 1
			end
		end
	end

	def flop
		3.times do 
			card = @deck.give_card
			@table.community_cards(card) 
		end
	end

	def turn
		card = @deck.give_card
		@table.community_cards(card)
	end

	def river
		card = @deck.give_card
		@table.community_cards(card)
	end

	def self.clear
		@deck = []
	end
end