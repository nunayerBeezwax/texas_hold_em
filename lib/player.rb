class Player
	attr_reader :chips, :hole_cards, :name, :seat, :hand

	def initialize(seat, chips)
		@hole_cards = []
		@chips = chips
		@seat = seat
		@hand = []
	end

	def get_card(card)
		@hole_cards << card
	end

	def combine(board)
		self.hole_cards.each { |card| @hand << card }
		board.each { |card| @hand << card }
		Hand.new(@hand, self)
	end
end