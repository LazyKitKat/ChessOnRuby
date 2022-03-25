require_relative 'player'
require_relative 'board'
require_relative 'load_save'
require_relative 'module/instructions'

class Chess
    include Instructions
    include LoadSave


    def initialize
        @player_one = Player.new(:white)
        @player_two = Player.new(:black)
        @board = Board.new
        @current_player = @player_one
        loop do
            pick = gets.chomp.downcase
            if pick == "l"
                if Dir.exist?('save_files')
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

    def end_game
        color = @current_player.color

    end

    def play
        finished = false
        result = ""
        puts help()
        until finished 
            color = @current_player.color
            chess_board = @board.chess_board
            which_castle = ""
            pick = ""
            destination = ""
            
           
            @board.print
            puts "#{@current_player.color}'s move." 
            

            loop do
                puts "Choose your piece: "
                print "$ > " 
                pick = gets.chomp

                break if pick.downcase == "r" 
                
                
                if pick == "save"
                    print "Enter a file name: "
                    filename = gets.chomp
                    save(filename)
                    next
                end
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
                    next
                    else
                        break
                    end
                end 
                if pick.downcase == "c" && !@board.can_castle?(@current_player.color)
                    puts "You can't castle."
                end
                if @board.valid_pick?(color, pick)
                    break
                end
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
            
            valid = false
            loop do
                puts "Pick your destination:"
                print "$ >> "
                destination = gets.chomp
                if @board.valid_move?(pick, destination)
                    break
                end
            end
            @board.move_piece(pick, destination)


            @current_player.check = false if @current_player.check == true
            
            switch_player()

            if @board.check?(color)
                @current_player.check = true
                puts "Check!"
            end
        end
        switch_player()
        puts "#{@current_player.color.capitalize} won!"
    end



end