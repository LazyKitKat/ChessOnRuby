module Mock
    def create_mock(board)
        created = Marshal.dump(board)
        return Marshal.load(created)
    end

    def can_attack_king?(start_row, start_col, board, color)
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
            moves = horizontal_moves() + vertical_moves() + diagonal_moves()
            moves.each do |move|
                loop do
                    start_row += move[0]
                    start_col += move[1]
                    break if start_row > 7 || start_col > 7 || start_row < 0 || start_col < 0
                    next if board[start_row][start_col] == nil 
                    break if board[start_row][start_col] != nil && board[start_row][start_col].type != :king 
                    break if board[start_row][start_col].color == color
                    return true
                end
            end
            return false
        when :rook
            moves = horizontal_moves() + vertical_moves()
            moves.each do |move|
                loop do
                    start_row += move[0]
                    start_col += move[1]
                    break if start_row > 7 || start_col > 7 || start_row < 0 || start_col < 0
                    next if board[start_row][start_col] == nil 
                    break if board[start_row][start_col] != nil && board[start_row][start_col].type != :king 
                    break if board[start_row][start_col].color == color
                    return true
                end
            end
            return false
        when :bishop
            moves = diagonal_moves()
            moves.each do |move|
                loop do
                    start_row += move[0]
                    start_col += move[1]
                    break if start_row > 7 || start_col > 7 || start_row < 0 || start_col < 0
                    next if board[start_row][start_col] == nil 
                    break if board[start_row][start_col] != nil && board[start_row][start_col].type != :king 
                    break if board[start_row][start_col].color == color
                    return true
                end
            end
            return false
        when :knight
            moves = [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [-1, 2], [2, -1], [-2, 1]]
            moves.each do |move|
                start_row += move[0]
                start_col += move[1]
                next if start_row > 7 || start_col > 7 || start_row < 0 || start_col < 0
                return true if board[start_row][start_col] != nil && board[start_row][start_col].color != color && board[start_row][start_col].type == :king
            end
            false
        end
    end
end