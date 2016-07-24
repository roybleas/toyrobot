require 'strscan'

class CommandParserError < StandardError
end

class CommandParser
  
  def parse(inputText)
    text = inputText.strip
    return [] if text.size == 0
    return extract_commands(text)
  end
  
  private
  
  def extract_commands(text)
    regexpError = /\s*\w+\b\s*/
    regexp = /\s*MOVE\s+|\s*REPORT\s+|\s*LEFT\s+|\s*RIGHT\s+|\s*PLACE \d,\d,\w+\b\s+|^\s*#.*$/
    
    commandList = []
    text = text + " "
    
    scanner = StringScanner.new(text)
    
    while !scanner.eos?
      command = scanner.scan(regexp)
      break if command.nil?
      commandList << command.strip unless invalid_command?(command)  
    end
    
    if !scanner.eos?
      invalidInstruction = scanner.check(regexpError)
      raise CommandParserError, "Invalid instruction at #{scanner.pos} : #{invalidInstruction}"
    end
    
    return commandList
  end 
  
  def invalid_command?(command)
    regexpPlace = /(\d),(\d),(WEST|NORTH|EAST|SOUTH)/
		regexpCommands = /MOVE|REPORT|LEFT|RIGHT/
    regexpComment = /\s*#.*/

    return false if command.match(regexpCommands )
    return true if command.match(regexpComment)
    return false if command.match(regexpPlace)
    raise CommandParserError, "Invalid PLACE instruction : #{command}"
    return true
  end
end