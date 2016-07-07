#!/usr/bin/env ruby

# ./run.rb ./runfiles/test01.txt ./runfiles/test02.txt ./runfiles/test03.txt ./runfiles/test04.txt ./runfiles/test05.txt
# 
# Outputs 
#
#	0,0,NORTH 
# 0,1,NORTH 
# 4,3,SOUTH 
# 4,0,SOUTH 
# 0,1,NORTH 
# 0,0,WEST 
# 3,3,NORTH 


require './lib/inputfiles'
require './lib/robot'

command_list_text = Inputfiles.new.read

robot = Robot.new
robot.feed_instructions(command_list_text)
robot.run
