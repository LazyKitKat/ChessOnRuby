module Mock

    def find_king(color, board)
        for i in 0..7
            for j in 0..7
                next if board[i][j].nil?
                next if board[i][j].color != color
                next if board[i][j].type != :king
                return [i, j]
            end
        end
    end

    def enemy_pieces(color)
        arr = []
        for i in 0..7
            for j in 0..7
                if @chess_board[i][j] != nil
                    if @chess_board[i][j].color != color
                        arr << @chess_board[i][j]
                    end
                end
            end
        end
        arr
    end

    def check?(color, board = @chess_board)
        king_pos = find_king(color, board)
        arr = enemy_pieces(color)
        arr.each do |piece|
            coord = piece_coord(piece, board)
            if valid_move?(coord, king_pos, board)
                return true
            end
        end
        return false
    end

end