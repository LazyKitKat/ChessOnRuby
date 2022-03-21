require_relative 'lib/module/instructions'
require_relative 'lib/chess'

puts <<-INTRO 
Welcome to the game of chess! 
Rules are simple.
First, do you want to (l)oad, (s)tart new game or (e)xit? 
INTRO

chess = Chess.new