class Player
    attr_reader :color
    attr_accessor :check
    def initialize(color, check = false)
        @color = color 
        @check = check
    end
end