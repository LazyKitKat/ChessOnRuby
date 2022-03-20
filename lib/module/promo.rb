module Promo
    def promotion(end_row, end_col, board)
        color = board[end_row][end_col].color 
        puts "Pick your new piece:"
        case color
        when :black
            puts "Q:\u2655"
            puts "R:\u2656"
            puts "B:\u2657"
            puts "K:\u2658"
        when :white
            puts "Q:\u265b"
            puts "R:\u265c"
            puts "B:\u265d"
            puts "K:\u265e"
        end
        promo = gets.chomp
        until "qrbk".include?(promo.downcase)
            puts "Enter a correct value."
            promo = gets.chomp
        end

        ## Pick
        
        if promo == "q"
            board[end_row][end_col] = Piece.new(color, :queen)
        elsif promo == "r"
            board[end_row][end_col] = Piece.new(color, :rook)
        elsif promo == "b"
            board[end_row][end_col] = Piece.new(color, :bishop)
        elsif promo == "k"
            board[end_row][end_col] = Piece.new(color, :knight)
        end
    end

end