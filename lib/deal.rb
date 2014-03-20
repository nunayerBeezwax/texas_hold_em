class Deal

	attr_reader :deck, :table

	def initialize
		@deck = Deck.new
		@deck.deck.shuffle!
		@table = Table.new(9)	
	end

	def preflop
		i = 0
		until @table.table[8].hand.length == 2
			@table.table.each do |player|
				player.get_card(@deck.deck[i])
				i += 1
			end
		end
	end

	def Deal.clear
		@deck = []
	end
end