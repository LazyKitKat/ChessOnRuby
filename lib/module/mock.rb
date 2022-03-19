module Mock
    def create_mock(board)
        return Marshal.dump(board)
    end
    def load_mock(board)
        return Marshal.load(board)
    end
end