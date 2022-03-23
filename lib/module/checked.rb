module Checked
    def is_checked?(color, mock)
        color == :white ? enemy = :black : enemy = :white
        king_position = find_king(color, mock)
        for i in 0..7
            for j in 0..7
                if mock[i][j] != nil
                    if mock[i][j].color == enemy
                        if can_attack_king?(i, j, king_position, mock)
                            return true
                        end
                    end
                end
            end
        end
        return false
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

    def horizontal_moves
        [[0,1], [0,-1]]
    end
    def vertical_moves
        [[1,0], [-1,0]]
    end
    def diagonal_moves
        [[1,1], [1,-1], [-1,1], [-1,-1]]
    end
    
    def can_attack_king?(start_row, start_col, king_position, board)
        piece = board[start_row][start_col]
        type = piece.type
        color = piece.color
        
        case type 
        when :pawn
            if piece.color == :black
                valid_moves = [[1,1],[1,-1]]
            else
                valid_moves = [[-1,1],[-1,-1]]
            end
            possible_attacks = Array.new
                valid_moves.each do |mv|
                    possible_attacks << [mv[0] + start_row, mv[1] + start_col]
                end
            return true if possible_attacks.include?(king_position)
        when :queen
            possible_attacks = Array.new
            moves = [[1,1], [1,-1], [-1,1], [-1,-1], [1,0], [-1,0], [0,1], [0,-1]]
            row = start_row
            col = start_col
            moves.each do |mv|
                loop do
                    row += mv[0]
                    col += mv[1]
                    break if row > 7 || col > 7 || row < 0 || col < 0
                    break if board[row][col] != nil && board[row][col].color == color
                    possible_attacks << [row, col]
                    break if board[row][col] != nil && board[row][col].color != color
                end
            end
            return true if possible_attacks.include?(king_position)
        when :knight
            possible_attacks = Array.new
            moves = [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [-1, 2], [2, -1], [-2, 1]]
            moves.each do |mv|
                next if start_row + mv[0] > 7 || start_col + mv[1] > 7 || start_row + mv[0] < 0 || start_col + mv[1] < 0
                next if board[start_row + mv[0]][start_col + mv[1]] != nil && board[start_row + mv[0]][start_col + mv[1]].color == color
                possible_attacks << [start_row + mv[0], start_col + mv[0]]
            end
            return true if possible_attacks.include?(king_position)
        when :bishop
            possible_attacks = Array.new
            moves = [[1,1], [1,-1], [-1,1], [-1,-1]]
            row = start_row
            col = start_col
            moves.each do |mv|
                loop do
                    row += mv[0]
                    col += mv[1]
                    break if row > 7 || col > 7 || row < 0 || col < 0
                    break if board[row][col] != nil && board[row][col].color == color
                    possible_attacks << [row, col]
                    break if board[row][col] != nil && board[row][col].color != color
                end
            end
            return true if possible_attacks.include?(king_position)
        when :rook
            possible_attacks = Array.new
            moves = [[1,0], [-1,0], [0,1],[0,-1]]
            row = start_row
            col = start_col
            moves.each do |mv|
                loop do
                    row += mv[0]
                    col += mv[1]
                    break if row > 7 || col > 7 || row < 0 || col < 0
                    break if board[row][col] != nil && board[row][col].color == color
                    possible_attacks << [row, col]
                    break if board[row][col] != nil && board[row][col].color != color
                end
            end
            return true if possible_attacks.include?(king_position)
        end
        false
    end
    
    def check_after_move?(start_row, start_col, end_row, end_col, board)
        mock = create_mock(board)
        color = mock[start_row][start_col].color
        mock[end_row][end_col] = mock[start_row][start_col]
        mock[start_row][start_col] = nil
        if is_checked?(color, mock) 
            return true
        else
            return false
        end
    end

    def has_any_valid_moves?(color, board)
        for i in 0..7
            for j in 0..7
                
            end
        end
    end

    def result
    end
end