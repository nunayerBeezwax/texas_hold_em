class Game
	attr_reader :table, :dealer

	def initialize
		@table = Table.new(9)
		@dealer = Dealer.new(@table)
	end


end