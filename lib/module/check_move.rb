module CheckMove
    def valid_king_move?(start_row, start_col, end_row, end_col, board)
        return false if (start_col - end_col).abs > 1 || (start_row - end_row).abs > 1 || start_row == end_row && start_col = end_col
        if !board[end_row][end_col].nil?
            if board[end_row][end_col].color == board[start_row][start_col].color
                return false
            else
                return true
            end
        else
            return true
        end
    end

    def valid_queen_move?(start_row, start_col, end_row, end_col, board)
        return false if start_col == end_col && start_row == end_row
        if start_col == end_col
            return valid_vertical_move?(start_row, start_col, end_row, end_col, board)
        elsif start_row == end_row
            return valid_horizotnal_move?(start_row, start_col, end_row, end_col, board)
        elsif (end_row - start_row).abs == (start_col - end_col).abs
            return valid_horizotnal_move?(start_row, start_col, end_row, end_col, board)
        else
            false
        end
    end

    def valid_pawn_move?(start_row, start_col, end_row, end_col, board)

        return false if start_row == end_row && start_col = end_col

        if valid_pawn_attack?(start_row, start_col, end_row, end_col, board)
            return true    
        end

        
        return false if start_col != end_col
        
        if board[start_row][start_col].color == :white
            return false if start_row < end_row
        else
            return false if start_row > end_row
        end
        
        if board[start_row][start_col].moved == false
            distance = 2
        else
            distance = 1
        end
        return false if (start_row - end_row).abs > distance
        if !board[end_row][end_col].nil?
            return false
        else
            return true
        end
    end     

    def valid_knight_move?(start_row, start_col, end_row, end_col, board)

        return false if  board[end_row][end_col] != nil && board[end_row][end_col].color == board[start_row][start_col].color

        start_pos = [start_row, start_col]
        valid_moves = [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [-1, 2], [2, -1], [-2, 1]]
        move = valid_moves.each.map do |move|
            move.each_with_index.map { |num, i| num + start_pos[i] unless num + start_pos[i] > 7 || num + start_pos[i] < 0 }
        end
        move.delete_if { |i| i.include?(nil) }
        return true if move.include?([end_row, end_col])
        false
    end

    def valid_pawn_attack?(start_row, start_col, end_row, end_col, board)
        if board[start_row][start_col].color == :white
            attack_left = [-1, -1]
            attack_right = [-1, 1]
        else
            attack_left = [1, -1]
            attack_right = [1, 1]
        end
        return false if [end_row - start_row, end_col - start_col] != attack_left || [end_row - start_row, end_col - start_col] != attack_right

        true

    end

    def valid_rook_move?(start_row, start_col, end_row, end_col, board)
        if start_row == end_row
            valid_horizotnal_move?(start_row, start_col, end_row, end_col, board)
        elsif start_col == end_col
            valid_vertical_move?(start_row, start_col, end_row, end_col, board)
        else
            false
        end
    end

    def valid_horizotnal_move?(start_row, start_col, end_row, end_col, board)
        return false if board[end_row][end_col].color == board[start_row][start_col].color
        until end_col == start_col
            return false if board[start_row][start_col + 1] != nil && board[start_row][start_col] != board[end_row][end_col]
            if start_col > end_col
                start_col -= 1
            else
                start_col += 1
            end
        end
        true
    end

    def valid_vertical_move?(start_row, start_col, end_row, end_col, board)
        return false if board[end_row][end_col].color == board[start_row][start_col].color
        until end_col == start_col
            return false if board[start_row + 1][start_col] != nil && board[start_row + 1][start_col] != board[end_row][end_col]
            if start_row > end_row
                start_row -= 1
            else
                start_row += 1
            end
        end
        true
    end

    def valid_diagonal_move?(start_row, start_col, end_row, end_col, board)
        d_one = end_row - start_row
        d_two = end_col - start_col
        return false if board[end_row][end_col].color == board[start_row][start_col].color
        until start_row == end_row
            if d_one > 0 && d_two > 0
                start_row += 1
                end_row += 1
            elsif d_one > 0 && d_two < 0
                start_row += 1
                end_row -= 1
            elsif d_one < 0 && d_two < 0
                start_row -= 1
                end_row -= 1
            else
                start_row -= 1
                end_row += 1
            end
            return false if board[start_row][start_col] != nil && board[start_row][start_col] != board[end_row][end_col]
        end
        true
    end
    def has_valid_move?(start_row, start_col, board)
        type = board[start_row][start_col].type
        case type
        when :pawn
            for i in -1..1
                for j in -1..1
                    next if start_row + i > 7 || start_row + i < 0 || start_col + j < 0 || start_col + j > 7
                    return true if valid_pawn_move?(start_row, start_col, start_row + i, start_col + j, board)
                end
            end
            false
        when :queen
            for i in -1..1
                for j in -1..1
                    next if start_row + i > 7 || start_row + i < 0 || start_col + j < 0 || start_col + j > 7
                    return true if valid_queen_move?(start_row, start_col, start_row + i, start_col + j, board)
                end
            end
            false
        when :king
            for i in -1..1
                for j in -1..1
                    next if start_row + i > 7 || start_row + i < 0 || start_col + j < 0 || start_col + j > 7
                    return true if valid_king_moves?(start_row, start_col, start_row + i, start_col + j, board)
                end
            end
            false
        when :bishop
            for i in -1..1
                for j in -1..1
                    next if start_row + i > 7 || start_row + i < 0 || start_col + j < 0 || start_col + j > 7
                    return true if valid_diagonal_move?(start_row, start_col, start_row + i, start_col + j, board)
                end
            end
            false
        when :knight
           valid_moves = [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [-1, 2], [2, -1], [-2, 1]]
           valid_moves.each do |move|
                return true if valid_knight_move?(start_row, start_pos, move[0] + start_row, move[1] + start_col, board)
           end
           false
        when :rook
            for i in -1..1
                for j in -1..1
                    next if start_row + i > 7 || start_row + i < 0 || start_col + j < 0 || start_col + j > 7
                    return true if valid_rook_move?(start_row, start_col, start_row + i, start_col + j, board)
                end
            end
            false
        end
    end
end