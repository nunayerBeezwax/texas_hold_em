class Deck

attr_reader :suit, :rank

	@@deck = []
	
	def initialize
	rank = %w{ 2 3 4 5 6 7 8 9 10 11 12 13 14 }
	suit = %w{ C S H D }
		suit.each do |suit| 
			rank.each do |rank| 
				@@deck << Card.new(suit, rank)
			end
		end
	end

	def deck
		@@deck
	end

	def Deck.clear
		@@deck = []
	end
end