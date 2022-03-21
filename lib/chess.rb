require_relative 'player'
require_relative 'board'
require_relative 'load_save'
require_relative 'module/instructions'

class Chess
    include Instructions


    def initialize
        @player_one = Player.new(:white)
        @player_two = Player.new(:black)
        @board = Board.new
        @current_player = @player_one
        loop do
            pick = gets.chomp.downcase
            if pick == "l"
                if Dir.exist?('../save_files')
                    load()
                    play()
                    break
                else
                    puts "No save files"
                end
            elsif pick == "s"
                play()
                break
            elsif pick == "e"
                return
            else
                puts "Invalid pick"
            end
        end
    end

    def switch_player
        @current_player == @player_one ? @current_player = @player_two : @current_player = @player_one
    end

    def play
        finished = false
        result = ""


        help()
        until finished 
            color = @current_player.color
            which_castle = ""
            @board.print
            puts "#{@current_player.color}'s move." 
            puts "Choose your piece: "
            print "$ > " 
            pick = gets.chomp

            until @board.valid_pick?(@current_player.color, pick)
                break if pick.downcase == "r" 
                if pick.downcase == "c" && @board.can_castle?(@current_player.color)
                    puts castle_help()
                    
                    statement = "c"
                    statement += "k" if @board.can_castle_king?(color)
                    statement += "q" if @board.can_castle_queen?(color)

                    which_castle = gets.chomp
                    until statement.include?(which_castle)
                        puts "Invalid input."
                        castle_help()
                        which_castle = gets.chomp
                    end
                    if which_castle == "c"
                        which_castle = ""
                    else
                        break
                    end
                end 
                if pick.downcase == "c" && !@board.can_castle?(@current_player.color)
                    puts "You can't castle."
                end
                puts "Invalid pick"
                print "$ > " 
                pick = gets.chomp
                pick = pick.capitalize
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
            switch_player()
        end
        if result == "win"
            puts "#{@current_player.color.capitalize} won!"
        elsif result == "draw"
            puts "Draw. Good job fellas!"
        end
    end
end