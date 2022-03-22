module MoveHelper
    def horizontal_moves
        [[0,1], [0,-1]]
    end
    def vertical_moves
        [[1,0], [-1,0]]
    end
    def diagonal_moves
        [[1,1], [1,-1], [-1,1], [-1,-1]]
    end
end