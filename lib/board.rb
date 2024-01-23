class Board
    attr_accessor :grid

    def initialize
        @white_listed = ["\u2654", "\u2655", "\u2656", "\u2657", "\u2658", "\u2659"]
        @black_listed = ["\u265A", "\u265B", "\u265C", "\u265D", "\u265E", "\u265F"]
        @grid = Array.new(8) { Array.new(8," ") }
        setup_board
    end
    def valid_coordinates?(row, col)
        row.between?(0,7) && col.between?(0,7)
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
    def valide_move_pawnes(start)
        valide_moves = []
        row = start[0]
        col = start[1]
        if valid_coordinates?(row, col) && @grid[row][col] == "\u2659" || @grid[row][col] == "\u265F"
            if @grid[row][col] == "\u2658" #white knight

                if row == 1 
                    valide_moves << [row + 1, col] if @grid[row + 1][col] == " "
                    valide_moves << [row + 2, col] if @grid[row + 2][col] == " "
           
                 elsif grid[row + 1][col] ==" "
                     valide_moves << [row + 1, col]
                end
                valide_moves << [row + 1, col - 1]  if @black_listed.include?(@grid[row + 1][col - 1]) 
                valide_moves << [row + 1, col + 1] if @black_listed.include?(@grid[row + 1][col + 1]) 
            end
            if @grid[row][col] == "\u265E" #black knight
                if row == 6 
                    valide_moves << [row - 1, col] if @grid[row - 1][col] == " "
                    valide_moves << [row - 2, col] if @grid[row - 2][col] == " "
                elsif grid[row][col] !=" "
                    valide_moves << [row - 1, col]
                end
                valide_moves << [row - 1, col - 1]  if @white_listed.include?(@grid[row - 1][col - 1]) 
                valide_moves << [row - 1, col + 1] if @white_listed.include?(@grid[row - 1][col + 1]) 
            end
            valide_moves
        else
            []
        end
    end

    def valide_move_knight(start)
        valide_moves = []
        row = start[0]
        col = start[1]
      
        if valid_coordinates?(row, col) && (@grid[row][col] == "\u2658" || @grid[row][col] == "\u265E")
          possible_moves = [
            [row + 2, col - 1], [row + 2, col + 1],
            [row + 1, col - 2], [row + 1, col + 2],
            [row - 1, col - 2], [row - 1, col + 2],
            [row - 2, col - 1], [row - 2, col + 1]
          ]
          
          possible_moves.each do |move|
            r, c = move
            if valid_coordinates?(r, c)
              if @grid[row][col] == "\u2658" && (@grid[r][c] == " " || @black_listed.include?(@grid[r][c]))
                valide_moves << move
              elsif @grid[row][col] == "\u265E" && (@grid[r][c] == " " || @white_listed.include?(@grid[r][c]))
                valide_moves << move
              end
            end
          end
        end
      
        valide_moves
    end
    

    def valide_move_rook(start)
        valide_moves = []
        row = start[0]
        col = start[1]
        if valid_coordinates?(row, col) && (@grid[row][col] == "\u2656" || @grid[row][col] == "\u265C")
            (row..7).each do |r|
                if r != row
                    if @grid[r][col] == " "
                        valide_moves << [r, col]
                    elsif @grid[row][col] == "\u2656" && @white_listed.include?(@grid[r][col])
                        break

                    elsif @grid[row][col] == "\u2656" && @black_listed.include?(@grid[r][col])
                        valide_moves << [r, col]
                        break
                    elsif @grid[row][col] == "\u265C" && @black_listed.include?(@grid[r][col])
                        break
                    elsif @grid[row][col] == "\u265C" && @white_listed.include?(@grid[r][col])
                        valide_moves << [r, col]
                        break
                    end
                end
            end
            0.upto(row) do |r|
                if r != row
                    if @grid[r][col] == " "
                        valide_moves << [r, col]
                    elsif @grid[row][col] == "\u2656" && @white_listed.include?(@grid[r][col])
                        break

                    elsif @grid[row][col] == "\u2656" && @black_listed.include?(@grid[r][col])
                        valide_moves << [r, col]
                        break
                    elsif @grid[row][col] == "\u265C" && @black_listed.include?(@grid[r][col])
                        break
                    elsif @grid[row][col] == "\u265C" && @white_listed.include?(@grid[r][col])
                        valide_moves << [r, col]
                        break
                    end
                end
            end
            (col..7).each do |c|
                if c != col
                    if @grid[row][c] == " "
                        valide_moves << [row, c]
                    elsif @grid[row][col] == "\u2656" && @white_listed.include?(@grid[row][c])
                        break
                    elsif @grid[row][col] == "\u2656" && @black_listed.include?(@grid[row][c])
                        valide_moves << [row, c]
                        break
                    elsif @grid[row][col] == "\u265C" && @black_listed.include?(@grid[row][c])
                        break
                    elsif @grid[row][col] == "\u265C" && @white_listed.include?(@grid[row][c])
                        valide_moves << [row, c]
                        break
                    end
                end
            end
            
            0.upto(col) do |c|
                if c != col
                    if @grid[row][c] == " "
                        valide_moves << [row, c]
                    elsif @grid[row][col] == "\u2656" && @white_listed.include?(@grid[row][c])
                        break
                    elsif @grid[row][col] == "\u2656" && @black_listed.include?(@grid[row][c])
                        valide_moves << [row, c]
                        break
                    elsif @grid[row][col] == "\u265C" && @black_listed.include?(@grid[row][c])
                        break
                    elsif @grid[row][col] == "\u265C" && @white_listed.include?(@grid[row][c])
                        valide_moves << [row, c]
                        break
                    end
                end
            end  
        end
        valide_moves
    end
    def valide_move_bishop(start)
        valide_moves = []
        row = start[0]
        col = start[1]
        if valid_coordinates?(row, col) && (@grid[row][col] == "\u2657" || @grid[row][col] == "\u265D")
            # move diagonally up-right
            (row-1).downto(0).zip(col+1..7) do |r, c|
                if @grid[r][c] == " "
                    valide_moves << [r, c]
                elsif @grid[row][col] == "\u2657" && @white_listed.include?(@grid[r][c])
                    break
                elsif @grid[row][col] == "\u2657" && @black_listed.include?(@grid[r][c])
                    valide_moves << [r, c]
                    break
                elsif @grid[row][col] == "\u265D" && @black_listed.include?(@grid[r][c])
                    break
                elsif @grid[row][col] == "\u265D" && @white_listed.include?(@grid[r][c])
                    valide_moves << [r, c]
                    break
                end
            end
            # move diagonally down-right
            (row+1..7).zip(col+1..7) do |r, c|
                if @grid[r][c] == " "
                    valide_moves << [r, c]
                elsif @grid[row][col] == "\u2657" && @white_listed.include?(@grid[r][c])
                    break
                elsif @grid[row][col] == "\u2657" && @black_listed.include?(@grid[r][c])
                    valide_moves << [r, c]
                    break
                elsif @grid[row][col] == "\u265D" && @black_listed.include?(@grid[r][c])
                    break
                elsif @grid[row][col] == "\u265D" && @white_listed.include?(@grid[r][c])
                    valide_moves << [r, c]
                    break
                end
            end
            # move diagonally up-left
            (row-1).downto(0).zip((col-1).downto(0).to_a.reverse) do |r, c|
                if @grid[r][c] == " "
                    valide_moves << [r, c]
                elsif @grid[row][col] == "\u2657" && @white_listed.include?(@grid[r][c])
                    break
                elsif @grid[row][col] == "\u2657" && @black_listed.include?(@grid[r][c])
                    valide_moves << [r, c]
                    break
                elsif @grid[row][col] == "\u265D" && @black_listed.include?(@grid[r][c])
                    break
                elsif @grid[row][col] == "\u265D" && @white_listed.include?(@grid[r][c])
                    valide_moves << [r, c]
                    break
                end
            end
            # move diagonally down-left
            range1 = (row+1..7).to_a
            range2 = (col-1).downto(0).to_a.reverse
            range1.take(range2.length).zip(range2) do |r, c| 
                if @grid[r][c] == " "
                    valide_moves << [r, c]
                elsif @grid[row][col] == "\u2657" && @white_listed.include?(@grid[r][c])
                    break
                elsif @grid[row][col] == "\u2657" && @black_listed.include?(@grid[r][c])
                    valide_moves << [r, c]
                    break
                elsif @grid[row][col] == "\u265D" && @black_listed.include?(@grid[r][c])
                    break
                elsif @grid[row][col] == "\u265D" && @white_listed.include?(@grid[r][c])
                    valide_moves << [r, c]
                    break
                end
            end
        end
        valide_moves
    end
       
end
        
board = Board.new
board.grid[2][0]="\u2657"
board.display_board
puts board.valide_move_bishop([2,0]).inspect 

