module EnPassant
    def can_np?(start_row, start_col, end_row, end_col, board)
        color = np_color(start_row, start_col, board)
        case color
        when :black
            start_condition = 4
        when :white
            start_condition = 3
        end

        return false if start_row != start_condition

        if can_np_left?(start_row, start_col, end_row, end_col, board, color) || can_np_right?(start_row, start_col, end_row, end_col, board, color)
            @en_p << board[start_row][start_col]
            return true 
        else 
            return false
        end
    end

    def can_np_left?(start_row, start_col, end_row, end_col, board, color)
        if color == :black
            np = [1, -1]
        else
            np = [-1, -1]
        end
        return false if [end_row - start_row, end_col - start_col] != np
        if board[start_row][start_col - 1] != nil 
            if board[start_row][start_col - 1].type == :pawn && board[start_row][start_col - 1].color != color
                if color == :black
                    if board[start_row - 1][start_col - 1].nil?
                        return true
                    end
                    return false
                else
                    if board[start_row + 1][start_col - 1].nil?
                        return true
                    end
                    return false
                end
            end
        end
        false
    end

    def can_np_right?(start_row, start_col, end_row, end_col, board, color)
        if color == :black
            np = [1, 1]
        else
            np = [-1, 1]
        end
        return false if [end_row - start_row, end_col - start_col] != np
        if board[start_row][start_col + 1] != nil 
            if board[start_row][start_col + 1].type == :pawn && board[start_row][start_col + 1].color != color
                if color == :black
                    if board[start_row - 1][start_col + 1].nil?
                        return true
                    end
                    return false
                else
                    if board[start_row + 1][start_col + 1].nil?
                        return true
                    end
                    return false
                end
            end
        end
        false
    end

    def is_np?(start_row, start_col, end_row, end_col, board)
            if start_col != end_col && board[end_row][end_col].nil?
                return true
            else 
                return false
            end
    end

    def en_passant(row, col, board)
        color = np_color(row, col, board)
        if color == :black
            board[row - 1][col] = nil
        elsif color == :white
            board[row + 1][col] = nil
        end
    end

    def np_color(start_row, start_col, board)
        board[start_row][start_col].color == :black ? :black : :white
    end
end