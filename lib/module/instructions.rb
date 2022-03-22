module Instructions

    def intro
        <<-INTRO 
        Welcome to the game of chess! 
        Rules are simple.
        First, do you want to (l)oad, (s)tart new game or (e)xit? 
        INTRO
    end

    def help
        <<-HELP
        To move a figure, first pick one by typing a column letter 
        followed by a row number (eg. 'A1', without ''). 
        Then do the same to pick a field you want to move it to.
        If you want to castle type 'c'. If you're a coward, type 'r' to resign. 
        Put 'save' if you want to save a file.

        HELP
    end

    def castle_help 
        <<-CASTLE
        Choose a side to castle. 
        (q)ueen, (k)ing, (c)ancel.
        CASTLE
    end 

end