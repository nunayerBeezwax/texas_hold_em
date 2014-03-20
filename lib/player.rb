class Player
	attr_reader :chips, :hand

	def initialize(chips)
		@hand = []
		@chips = chips
	end

	def get_card(card)
		@hand << card
	end
end