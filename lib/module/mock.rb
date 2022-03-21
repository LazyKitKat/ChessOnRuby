module Mock
    def create_mock(board)
        created = Marshal.dump(board)
        return Marshal.load(created)
    end

    def valid_mock_move?(start_coords, end_position, board)
        piece = board[start_coords[0]][start_coords[1]]
        return false if end_position.nil?
        return false if start_coords.nil?

        case piece.type
        when :pawn
            valid_pawn_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], board)
        when :queen
            valid_queen_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], board)
        when :rook
            valid_rook_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], board)
        when :bishop
            valid_diagonal_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], board)
        when :king 
            valid_king_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], board)
        when :knight
            valid_knight_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], board)
        end
    end

    def mock_move(start_position, end_position, board)
        board[end_position[0]][end_position[1]] = board[start_position[0]][start_position[1]]
        board[start_position[0]][start_position[1]] = nil
        board[end_position[0]][end_position[1]].moved = true
        if board[end_position[0]][end_position[1]].type == :pawn
            if is_np?(start_position[0], start_position[1], end_position[0], end_position[1], board)
                if board[end_position[0]][end_position[1]].color == :black
                    board[end_position[0] - 1][end_position[1]] = nil
                else
                    board[end_position[0] + 1][end_position[1]] = nil
                end
            end
        end
        if board[end_position[0]][end_position[1]].type == :pawn
            if board[end_position[0]][end_position[1]].color == :black
                if end_position[0] == 7
                    promotion(end_position[0], end_position[1], board)
                end
            else
                if end_position[0] == 0
                    promotion(end_position[0], end_position[1], board)
                end
            end
        end
    end
end