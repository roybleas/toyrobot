require_relative 'table'
require_relative 'location'
require_relative 'commandparser'
require_relative 'commandfactory'

class Robot
	attr_reader :table, :current_location
	attr_accessor :command_list
	
	def initialize
		@table = Table.new()
		@command_list = []
		@current_location = Location.new()
	end

	def feed_instructions(text)
		command_parser = CommandParser.new()
		instruction_list = command_parser.parse(text)
		@command_list = instruction_list.map { |instruction| CommandFactory.create(instruction) }
	end
	
	def run
		@command_list.each do |command|
			
			new_location = command.execute(@current_location)
			unless new_location.point.nil? 
				@current_location = new_location if table.valid_point?(new_location.point)
			end
		end
		
	end
end
