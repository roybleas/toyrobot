require 'strscan'

class CommandParserError < StandardError
end

class CommandParser
	def initialize()
		@MaxPointX = 4 
		@MaxPointY = 4
	end

	def parse(inputText)
		text = inputText.strip
		return [] if text.size == 0
		
		return extractCommands(text)
	end
	private
	
	def extractCommands(text)
		regexpError = /\s*\w+\b\s*/
		regexp = /MOVE\s|REPORT\s|LEFT\s|RIGHT\s|PLACE \d,\d,\w+\b\s/
		@regexpPlace = /(?<x>[0-#{@MaxPointX}]{1}),(?<y>[0-#{@MaxPointY}]){1},(?<f>WEST|NORTH|EAST|SOUTH){1}/
		
		commandList = []
		text = text + " "
		
		scanner = StringScanner.new(text)
		
		while !scanner.eos?
			command = scanner.scan(regexp)
			break if command.nil?
			commandList << command.strip unless commandIsInvalid?(command)	
		end
		
		if !scanner.eos?
			invalidInstruction = scanner.check(regexpError)
			raise CommandParserError, "Invalid instruction at #{scanner.pos} : #{invalidInstruction}"
		end
		
		return commandList
	end 
	
	def commandIsInvalid?(command)
		return false if command =~ /MOVE|REPORT|LEFT|RIGHT/
		return false if command.match(@regexpPlace)
		raise CommandParserError, "Invalid PLACE instruction : #{command}"
		return true
	end
end