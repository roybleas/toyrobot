Notes and Assumptions:

 Only instructions in upper case will be accepted. 

 Any malformed or unknown instruction will be logged as an error. The default logging class can be replaced by setting te Robot.logger attribute. The Robot class does not validate if the logger object passed belongs to class Logger.

 A # at the beginning of any input file line will cause the line to be ignored and treated as a comment.

 When loading multiple files each file must end with a LineFeed or space so commands do not merge together. 

Tests:

 The test files are located in /runfiles

 Tests can be run with file run.rb. It expects a file containing the instructions for the robot to be passed as an argument.
 eg
  ./run.rb ./runfiles/test01.txt


