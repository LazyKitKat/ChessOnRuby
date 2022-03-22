module Checked
    def is_checked?(color, mock)
        color == :white ? enemy = :black : enemy = :white
        king_position = find_king(color, mock)
        for i in 0..7
            for j in 0..7
                next if mock[i][j].nil?
                if mock[i][j].color == enemy
                    return true if valid_mock_move?([i,j], king_position, mock)
                end
            end
        end
        false
    end


    def find_king(color, board)
        for i in 0..7
            for j in 0..7
                next if board[i][j].nil?
                next if board[i][j].type != :king
                next if board[i][j].color != color
                return [i,j]    
            end
        end
    end
    
    def check_after_move?(start_row, start_col, end_row, end_col, color, board)
        mock = create_mock(board)
        start_position = [start_row, start_col]
        end_position = [end_row, end_col]
        mock_move(start_position, end_position, board)
        if is_checked?(color, mock) 
            return true
        end
        false
    end

    def has_any_valid_moves?(color, board)
    end
end