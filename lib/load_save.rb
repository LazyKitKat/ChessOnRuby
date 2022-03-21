require 'yaml'

module LoadSave
    def save(filename)
        Dir.mkdir('../save_files') unless Dir.exist?('../save_files')
        data = {
            board: @board,
            player_one: @player_one,
            player_two: @player_two,
            current_player: @current_player
        }
        file = File.new("../save_files/#{filename}.yml", "w") { |save| save.write(data.to_yaml) }
    end

    def load_game(filename)
        load_game = Yaml.load(File.read(filename))
        @board = load_game[:board]
        @player_one = load_game[:player_one]
        @player_two = load_game[:player_two]
        @current_player = load_game[:current_player]
    end

    def load
        if Dir.exist?('../save_files') && !Dir.empty?('../save_files')
            entries = Dir.entries("save_files").delete_if { |dir| dir == "." || dir == ".." }
            entries.each_with_index { |save, i| puts  (i + 1).to_s + ")" + save }
            pick_load = gets.chomp.to_i
            file_to_load = entries[pick_load - 1]
            until file_to_load != nil
                puts "Invalid pick."
                pick_load = gets.chomp.to_i
                file_to_load = entries[pick_load - 1]
            end
            load_game(file_to_load)
        else
            puts "There are no save files"
        end
    end
end