require 'strscan'

class CommandParserError < StandardError
end

class CommandParser
	
	def parse(inputText)
		text = inputText.strip
		return [] if text.size == 0
		return extractCommands(text)
	end
	
	private
	
	def extractCommands(text)
		regexpError = /\s*\w+\b\s*/
		regexp = /\s*MOVE\s+|\s*REPORT\s+|\s*LEFT\s+|\s*RIGHT\s+|\s*PLACE \d,\d,\w+\b\s+/
		regComment = /^\s*#.*$/
		
		commandList = []
		text = text + " "
		
		scanner = StringScanner.new(text)
		
		while !scanner.eos?
			scanner.skip(regComment)
			
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
		regexpPlace = /(\d),(\d),(WEST|NORTH|EAST|SOUTH)/
		return false if command =~ /MOVE|REPORT|LEFT|RIGHT/
		return false if command.match(regexpPlace)
		raise CommandParserError, "Invalid PLACE instruction : #{command}"
		return true
	end
end