
class InputFilesError < StandardError
end

class InputFiles
  def read
    if ARGV.length == 0
      raise InputFilesError, "Missing input file with list of commands."
    else
      ARGF.read
    end
  end
end