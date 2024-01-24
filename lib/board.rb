class Board
    attr_accessor :grid, :white_listed, :black_listed

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
        if valid_coordinates?(row, col) && (@grid[row][col] == "\u2659" || @grid[row][col] == "\u265F")
            if @grid[row][col] == "\u2659" #white pawn
                if row == 1 
                    valide_moves << [row + 1, col] if @grid[row + 1][col] == " "
                    valide_moves << [row + 2, col] if @grid[row + 2][col] == " "
                elsif @grid[row + 1][col] ==" "
                    valide_moves << [row + 1, col]
                end
                valide_moves << [row + 1, col - 1]  if @black_listed.include?(@grid[row + 1][col - 1]) 
                valide_moves << [row + 1, col + 1] if @black_listed.include?(@grid[row + 1][col + 1]) 
            end
            if @grid[row][col] == "\u265F" #black pawn
                if row == 6 
                    valide_moves << [row - 1, col] if @grid[row - 1][col] == " "
                    valide_moves << [row - 2, col] if @grid[row - 2][col] == " "
                elsif @grid[row - 1][col] ==" "
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
            rook_color = @grid[row][col] == "\u2656" ? "white" : "black"
            opponent_list = rook_color == "white" ? @black_listed : @white_listed
            own_list = rook_color == "white" ? @white_listed : @black_listed
    
            
            [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dx, dy|
                r, c = row + dx, col + dy
                while valid_coordinates?(r, c)
                    if @grid[r][c] == " "
                        valide_moves << [r, c]
                    elsif own_list.include?(@grid[r][c])
                        break
                    elsif opponent_list.include?(@grid[r][c])
                        valide_moves << [r, c]
                        break
                    end
                    r += dx
                    c += dy
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
            possible = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    
            possible.each do |move|
                r = row + move[0]
                c = col + move[1]
    
                loop do
                    break unless valid_coordinates?(r, c)
    
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
    
                    r += move[0]
                    c += move[1]
                end
            end
        end
    
        valide_moves
    end  

    def valide_move_queen(start)
        return valide_move_bishop(start) + valide_move_rook(start)
    end

    def valide_move_king(start)
        valide_moves = []
        row = start[0]
        col = start[1]
        possible_moves = [
          [row + 1, col], [row + 1, col + 1], [row + 1, col - 1],
          [row, col + 1], [row, col - 1],
          [row - 1, col], [row - 1, col + 1], [row - 1, col - 1]
        ]
      
        if valid_coordinates?(row, col) && (@grid[row][col] == "\u2654" || @grid[row][col] == "\u265A")
          possible_moves.each do |move|
            r = move[0]
            c = move[1]
      
            if valid_coordinates?(r, c) &&
               (@grid[row][col] == "\u2654" && (@grid[r][c] == " " || @black_listed.include?(@grid[r][c])) ||
                @grid[row][col] == "\u265A" && (@grid[r][c] == " " || @white_listed.include?(@grid[r][c])))
              valide_moves << move
            end
          end
        end
      
        valide_moves
    end
    def find_king(color)
        king = color == "white" ? "\u2654" : "\u265A"
    
        @grid.each_with_index do |row, i|
            row.each_with_index do |cell, j|
                return [i, j] if cell == king
            end
        end
    
        nil
    end
    
    def valide_move(start)
        valide_moves = []
        case @grid[start[0]][start[1]]
        when "\u2659","\u265F"
            valide_moves = valide_move_pawnes(start)
        when "\u2658", "\u265E"
            valide_moves = valide_move_knight(start)
        when "\u2656", "\u265C"
            valide_moves = valide_move_rook(start)
        when "\u2657", "\u265D"
            valide_moves = valide_move_bishop(start)
        when "\u2655", "\u265B"
            valide_moves = valide_move_queen(start)
        when "\u2654", "\u265A"
            valide_moves = valide_move_king(start)
        end
        valide_moves
    end
    def all_valide_move(color)
        valide_moves = []
        @grid.each_with_index do |row, i|
            row.each_with_index do |cell, j|
                if color == "white" && @white_listed.include?(cell)
                    valide_moves =  valide_moves + valide_move([i,j])
                elsif color == "black" && @black_listed.include?(cell)
                    valide_moves =  valide_moves + valide_move([i,j])
                end
            end
        end
        valide_moves
    end
    def checkmate?(color)
        king = find_king(color)
        king_moves = valide_move_king(king)
        all_moves = []
        king_moves << king
        if color == "white"
            all_moves = all_valide_move("black")
        else
            all_moves = all_valide_move("white")
        end
        return king_moves.all? { |move| all_moves.include?(move) }
        
    end

    def check?(color)
        king = find_king(color)
        if color == "white"
            all_moves = all_valide_move("black")
        else
            all_moves = all_valide_move("white")
        end
        return all_moves.include?(king)
    end

    def move(start,end_pos)
        @grid[end_pos[0]][end_pos[1]] = @grid[start[0]][start[1]]
        @grid[start[0]][start[1]] = " "
    end
    def reset_last_move(start,end_pos)
        @grid[start[0]][start[1]] = @grid[end_pos[0]][end_pos[1]]
        @grid[end_pos[0]][end_pos[1]] = " "
    end



end



