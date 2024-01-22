class Board
    attr_accessor :grid

    def initialize
        @grid = Array.new(8) { Array.new(8, " ") }
        setup_board
    end

    def setup_board
        # White pieces
        @grid[0][0] = "\u2656" # Rook
        @grid[0][1] = "\u2658" # Knight
        @grid[0][2] = "\u2657" # Bishop
        @grid[0][3] = "\u2655" # Queen
        @grid[0][4] = "\u2654" # King
        @grid[0][5] = "\u2657" # Bishop
        @grid[0][6] = "\u2658" # Knight
        @grid[0][7] = "\u2656" # Rook
        @grid[1].map! { "\u2659" } # Pawns

        # Black pieces
        @grid[7][0] = "\u265C" # Rook
        @grid[7][1] = "\u265E" # Knight
        @grid[7][2] = "\u265D" # Bishop
        @grid[7][3] = "\u265B" # Queen
        @grid[7][4] = "\u265A" # King
        @grid[7][5] = "\u265D" # Bishop
        @grid[7][6] = "\u265E" # Knight
        @grid[7][7] = "\u265C" # Rook
        @grid[6].map! { "\u265F" } # Pawns
    end

    def display_board
        puts "   A   B   C   D   E   F   G   H"
        puts " ---------------------------------"
        @grid.each_with_index do |row, index|
            puts "#{index + 1} | #{row.join(" | ")} | #{index + 1}"
            puts " ---------------------------------"
        end
        puts "   A   B   C   D   E   F   G   H"
    end

    def self.convert_to_index(key)
        if ("A".."H").include?(key[0].upcase) && ("1".."8").include?(key[1]) && key.length == 2
            column = key[0].upcase.ord - 'A'.ord
            row = key[1].to_i - 1
            return [row, column]
        end
        nil
    end
    
end







    
