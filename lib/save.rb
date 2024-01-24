require_relative "board.rb"
require 'json'

class Save 
    attr_accessor :board
    def initialize(board)
        @board = board
    end

    def save_game
        puts "Enter the name of the file"
        file_name = gets.chomp
        Dir.mkdir('save') unless Dir.exist?('save')
        File.open("./save/#{file_name}.json", "w") do |file|
            file.puts JSON.generate(@board.grid)
        end
    end

    def display_saved_game_names
        puts "Saved games:"
        Dir.glob("./save/*.json") do |file|
            puts file
        end
    end

    def load_game
        puts "Enter the name of the file"
        file_name = gets.chomp
        if File.exist?("./save/#{file_name}.json")
            file = File.open("./save/#{file_name}.json", "r")
            loaded_grid = JSON.parse(file.read)
            puts loaded_grid
            board.grid = loaded_grid
            board.display_board
        else
            puts "No saved game found with that name."
            nil
        end
    end
end

board = Board.new
save = Save.new(board)
save.save_game 
save.display_saved_game_names
save.load_game