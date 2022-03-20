module Castling

    def can_castle?(color)
        return true if can_castle_king?(color) || can_castle_queen?(color) 
        false
    end
    def can_castle_king?(color)
        if color == :black
            if @chess_board[0][4].moved && @chess_board[0][7].moved 
                false
            elsif !@chess_board[0][5].nil? && !@chess_board[0][6].nil?
                false
            else
                true
            end
        else
            if @chess_board[7][4].moved && @chess_board[7][7].moved 
                false
            elsif !@chess_board[7][5].nil? && !@chess_board[7][6].nil?
                false
            else
                true
            end
        end
    end

    def can_castle_queen?(color)
        if color == :black
            if @chess_board[0][4].moved && @chess_board[0][0].moved 
                false
            elsif !@chess_board[0][1].nil? && !@chess_board[0][2].nil? && !@chess_board[0][3].nil?
                false
            else
                true
            end
        else
            if @chess_board[7][4].moved && @chess_board[7][0].moved 
                false
            elsif !@chess_board[7][1].nil? && !@chess_board[7][2].nil? && !@chess_board[7][3].nil?
                false
            else
                true
            end
        end
    end

    def castle(color, val)
        if color == :black
            if val == "k"
                @chess_board[0][6] = @chess_board[0][4]
                @chess_board[0][4] = nil
                @chess_board[0][5] = @chess_board[0][7]
                @chess_board[0][7] = nil
            elsif val == "q"
                @chess_board[0][2] = @chess_board[0][4]
                @chess_board[0][4] = nil
                @chess_board[0][3] = @chess_board[0][7]
                @chess_board[0][7] = nil
            end
        else
            if val == "k"
                @chess_board[7][6] = @chess_board[7][4]
                @chess_board[7][4] = nil
                @chess_board[7][5] = @chess_board[7][7]
                @chess_board[7][7] = nil
            elsif val == "q"
                @chess_board[7][2] = @chess_board[7][4]
                @chess_board[7][4] = nil
                @chess_board[7][3] = @chess_board[7][7]
                @chess_board[7][7] = nil
            end
        end
    end
end