module Mock
    def create_mock(board)
        created = Marshal.dump(board)
        return Marshal.load(created)
    end
end