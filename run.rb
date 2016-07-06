#!/usr/bin/env ruby

require './lib/inputfiles'
require './lib/robot'

command_list_text = Inputfiles.new.read

robot = Robot.new
robot.feed_instructions(command_list_text)
robot.run
