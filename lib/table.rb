class Table

	attr_reader :table

	def initialize(num_of_players)
		@table = []
		9.times { @table << Player.new(1000) }
	end
end