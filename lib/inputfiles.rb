
class InputfilesError < StandardError
end

class Inputfiles
  def read
    if ARGV.length == 0
      raise InputfilesError, "Missing input file with list of commands."
    else
      ARGF.read
    end
  end
end