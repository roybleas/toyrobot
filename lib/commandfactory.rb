require_relative 'move'
require_relative 'turn'
require_relative 'report'
require_relative 'place'


class CommandFactoryError < StandardError
end

class CommandFactory
  class << self
    def create(typeof)
      obj = case typeof
        when "MOVE"
          Move.new()
        when "LEFT"
          Left.new()
        when "RIGHT"
          Right.new()
        when "REPORT"
          Report.new()
        when /PLACE /
          create_place(typeof)
        else
          raise CommandFactoryError,"Invalid Command type: #{typeof}"
      end
    end
  end
  
  private
  def self.create_place(command)
    regexp = /(?<x>\d),(?<y>\d),(?<f>\w+)/
    data = command.match(regexp)
    return Place.new(x: data[:x],y: data[:y],facing: data[:f])    
  end
end