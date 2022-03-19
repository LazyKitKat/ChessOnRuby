require_relative 'player'
require_relative 'board'
require_relative 'module/instructions'

class Chess
    include Instructions
    def initialize
        @player_one = Player.new(:white)
        @player_two = Player.new(:black)
        @board = Board.new
        @current_player = @player_one
    end

    def switch_player
        @current_player == @player_one ? @current_player = @player_two : @current_player = @player_one
    end

    def play
        finished = false
        result = ""


        help()
        until finished 
            

            which_castle = ""
            @board.print
            
            puts "#{@current_player.color}'s move." 
            puts "Choose your piece: "
            print "$ > " 
            pick = gets.chomp
            until @board.valid_pick?(@current_player.color, pick)
                break if pick.downcase == "r" 
                if pick.downcase == "c" && (@board.can_castle_king?(@curret_player.color) || @board.can_castle_queen?(@curret_player.color))
                    castle_help()
                    which_castle = gets.chomp
                    until "kcq".include?(which_castle)
                        puts "Invalid input."
                        castle_help()
                        which_castle = gets.chomp
                        next if which_castle == "k" && !@board.can_castle_king?(@curret_player.color)
                        next if which_castle == "q" && !@board.can_castle_queen?(@curret_player.color)
                    end
                    break unless which_castle == "c" 
                elsif pick.downcase == "c" && !@board.can_castle_king?(@curret_player.color) && !@board.can_castle_queen?(@curret_player.color)
                    puts "You can't castle."
                end
                puts "Invalid pick"
                print "$ > " 
                pick = gets.chomp
            end
            if pick == "c"
                @board.castle(color, which_castle)
                switch_player()
                next
            elsif pick == "r"
                switch_player()
                result = "win"
                finished = true
                next 
            end
            piece = @board.pick_piece(pick)
            puts "Pick your destination:"
            print "$ >> "
            destination = gets.chomp
            until @board.valid_move?(piece, destination)
                puts "Invalid input."
                puts "Pick your destination:"
                print "$ >> "
                destination = gets.chomp
            end
            @board.move_piece(piece, destination)
        end
        if result == "win"
            puts "#{@current_player.color.capitalize} won!"
        elsif result == "draw"
            puts "Draw. Good job fellas!"
        end
    end
end

a = Chess.new
a.play