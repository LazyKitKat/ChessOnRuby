require_relative 'piece'
require_relative 'module/instructions'
require_relative 'module/check_move'
require_relative 'module/castling'
require_relative 'module/promo'
require_relative 'module/checked'
require_relative 'module/en_p'

class Board

    attr_reader :chess_board
    attr_accessor :en_passant

    include CheckMove
    include EnPassant
    include Instructions
    include Castling
    include Promo
    
    def initialize
        @chess_board = Array.new(8) { Array.new(8) }
        @letters = [*("A".."H")]
        @numbers = [*("1".."8")]
        @en_p = []
        init_board()
    end
    
    def init_board
        #Kings
        @chess_board[7][4] = Piece.new(:white, :king)
        @chess_board[0][4] = Piece.new(:black, :king)
        #Queens
        @chess_board[7][3] = Piece.new(:white, :queen)
        @chess_board[0][3] = Piece.new(:black, :queen)
        #Bishops
        @chess_board[7][2] = Piece.new(:white, :bishop)
        @chess_board[7][5] = Piece.new(:white, :bishop)

        @chess_board[0][2] = Piece.new(:black, :bishop)
        @chess_board[0][5] = Piece.new(:black, :bishop)

        #Knights
        @chess_board[7][1] = Piece.new(:white, :knight)
        @chess_board[7][6] = Piece.new(:white, :knight)

        @chess_board[0][1] = Piece.new(:black, :knight)
        @chess_board[0][6] = Piece.new(:black, :knight)
        
        #Rooks
        @chess_board[7][0] = Piece.new(:white, :rook)
        @chess_board[7][7] = Piece.new(:white, :rook)

        @chess_board[0][0] = Piece.new(:black, :rook)
        @chess_board[0][7] = Piece.new(:black, :rook)
        
        #Pawns
        8.times { |i| @chess_board[1][i] = Piece.new(:black, :pawn) }
        8.times { |i| @chess_board[6][i] = Piece.new(:white, :pawn) }
    end

    def print
        for i in 0..7
            str = ""
            for j in 0..7
                @chess_board[i][j].nil? ? str += " |" : str += "#{@chess_board[i][j].symbol}|"
            end
            puts  @numbers[i] + "|" + str
        end
        puts "  A B C D E F G H"
    end

    def format_input(input)
        input = input.split("")
        return nil if input.length != 2 || !@numbers.include?(input[1]) || !@letters.include?(input[0]) 
        row = @numbers.index(input[1])
        col = @letters.index(input[0])
        return @chess_board[row][col]
    end

    def format_end_position(input)
        input = input.split("")
        return nil if input.length != 2 || !@numbers.include?(input[1]) || !@letters.include?(input[0]) 
        row = @numbers.index(input[1])
        col = @letters.index(input[0])
        return [row, col]
    end

    def valid_pick?(color, input)
        picked = format_input(input)
        position = format_end_position(input)
        return false if picked.nil?
        return false if !has_valid_move?(position[0], position[1], @chess_board)
        if picked.color != color
            return false
        else
            true
        end
    end

    def move_piece(piece, end_position)
        end_position = format_end_position(end_position)
        start_position = piece_coord(piece)
        @chess_board[end_position[0]][end_position[1]] = @chess_board[start_position[0]][start_position[1]]
        @chess_board[start_position[0]][start_position[1]] = nil
        @chess_board[end_position[0]][end_position[1]].moved = true
        p @en_p
        if @en_p.include?(@chess_board[end_position[0]][end_position[1]])
            if @chess_board[end_position[0]][end_position[1]].color == :black
                @chess_board[end_position[0] - 1][end_position[1]] = nil
            else
                @chess_board[end_position[0] + 1][end_position[1]] = nil
            end
            @en_p.shift
        end
        if @chess_board[end_position[0]][end_position[1]].type == :pawn
            if @chess_board[end_position[0]][end_position[1]].color == :black
                if end_position[0] == 7
                    promotion(end_position[0], end_position[1], @chess_board)
                end
            else
                if end_position[0] == 0
                    promotion(end_position[0], end_position[1], @chess_board)
                end
            end
        end
    end

    def valid_move?(piece, end_position)
        start_coords = piece_coord(piece)
        end_position = format_end_position(end_position)
        return false if end_position.nil?
        case piece.type
        when :pawn
            valid_pawn_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], @chess_board)
        when :queen
            valid_queen_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], @chess_board)
        when :rook
            valid_rook_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], @chess_board)
        when :bishop
            valid_diagonal_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], @chess_board)
        when :king 
            valid_king_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], @chess_board)
        when :knight
            valid_knight_move?(start_coords[0], start_coords[1], end_position[0], end_position[1], @chess_board)
        end
    end

    def pick_piece(input)
        return format_input(input)
    end

    def piece_coord(piece)
        for i in 0..7
            for j in 0..7
               return [i,j] if @chess_board[i][j] == piece
            end
        end
    end
end