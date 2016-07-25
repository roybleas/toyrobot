require 'strscan'
require 'logger'


class CommandParser
	def initialize(log = nil)
		@logger = log
		@logger ||= Logger.new(STDOUT) 
	end
  
  def parse(inputText)
    text = inputText.strip
    return [] if text.size == 0
    return extract_commands(text)
  end
  
  private
  
  def extract_commands(text)
    regexp = /\s*MOVE\s+|\s*REPORT\s+|\s*LEFT\s+|\s*RIGHT\s+|\s*PLACE \d,\d,\w+\b\s+|^\s*#.*$/
    
    commandList = []
    text = text + " "
    
    scanner = StringScanner.new(text)
    
    while !scanner.eos?
      command = scanner.scan(regexp)
     	unknown_command(scanner) if command.nil?
      commandList << command.strip unless invalid_command?(command)  
    end
        
    return commandList
  end 
  
  def unknown_command(scanner)
  	regexpError = /\s*\w+\b\s*/
  	scanner_pos = scanner.pos
  	invalidInstruction = scanner.scan_until(regexpError)
  	@logger.warn("Invalid instruction at #{scanner_pos} : #{invalidInstruction}")
  end
  
  def invalid_command?(command)
    regexpPlace = /(\d),(\d),(WEST|NORTH|EAST|SOUTH)/
		regexpCommands = /MOVE|REPORT|LEFT|RIGHT/
    regexpComment = /\s*#.*/

		return true if command.nil?
    return false if command.match(regexpCommands )
    return true if command.match(regexpComment)
    return false if command.match(regexpPlace)
    @logger.warn("Invalid PLACE instruction : #{command}")
    return true
  end
end