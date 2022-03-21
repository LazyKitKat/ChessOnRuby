module Checked
    def is_checked?(color, board = @chess_board)
        color == :white ? enemy = :black : enemy = :white
        king_position = find_king(color, board)
        for i in 0..7
            for j in 0..7
                next if board[i][j].nil?
                next if board[i][j].color != enemy
                return true if valid_move?(board[i][j], king_position) 
            end
        end
        false
    end

    def find_king(color, board)
        for i in 0..7
            for j in 0..7
                next if board[i][j].nil?
                if board[i][j].type == :king
                    if board[i][j].color == color
                        return [i,j]
                    end
                end
            end
        end
    end
    def will_result_in_check?(color, board)
    end

    def has_any_valid_moves?(color, board)
    end
end