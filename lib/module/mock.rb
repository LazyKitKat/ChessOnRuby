module Mock
    def create_mock(board)
        created = Marshal.dump(board)
        return Marshal.load(created)
    end
=begin
    def can_attack_king?(start_row, start_col, end_row, end_col board, color)
        type = board[start_row][start_col].type
        case type
        when :pawn
            if board[start_row][start_col].color == :black
                if board[start_row + 1][start_col + 1].type == :king && board[start_row + 1][start_col + 1].color != color || board[start_row + 1][start_col - 1] && board[start_row + 1][start_col - 1].color != color
                    return true
                end
            else
                if board[start_row - 1][start_col + 1].type == :king && board[start_row - 1][start_col + 1].color != color || board[start_row - 1][start_col - 1] && board[start_row - 1][start_col - 1].color != color
                    return true
                end
            end
            false
        when :queen
            
        when :rook
        when :bishop
        when :knight
        end
    end
=end
end