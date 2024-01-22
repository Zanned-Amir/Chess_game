class ChessPieces
    def self.pawn_moves(start, grid)
        valid_moves = []
        row, col = start
        piece = grid[row][col]

        if piece == "\u2659" # white pawn
            if grid[row - 1][col] == " "
                valid_moves << [row - 1, col]
            end
            if row == 6 && grid[row - 1][col] == " " && grid[row - 2][col] == " "
                valid_moves << [row - 2, col]
            end
            if col > 0 && grid[row - 1][col - 1] != " " && grid[row - 1][col - 1] != piece
                valid_moves << [row - 1, col - 1]
            end
            if col < 7 && grid[row - 1][col + 1] != " " && grid[row - 1][col + 1] != piece
                valid_moves << [row - 1, col + 1]
            end
        elsif piece == "\u265F" # black pawn
            if grid[row + 1][col] == " "
                valid_moves << [row + 1, col]
            end
            if row == 1 && grid[row + 1][col] == " " && grid[row + 2][col] == " "
                valid_moves << [row + 2, col]
            end
            if col > 0 && grid[row + 1][col - 1] != " " && grid[row + 1][col - 1] != piece
                valid_moves << [row + 1, col - 1]
            end
            if col < 7 && grid[row + 1][col + 1] != " " && grid[row + 1][col + 1] != piece
                valid_moves << [row + 1, col + 1]
            end
        end

        valid_moves
    end

    def self.rook_moves(start, grid)
        valid_moves = []
        row, col = start
        piece = grid[row][col]

        # up
        (row - 1).downto(0) do |i|
            if grid[i][col] == " "
                valid_moves << [i, col]
            elsif grid[i][col] != piece
                valid_moves << [i, col]
                break
            else
                break
            end
        end

        # down
        (row + 1).upto(7) do |i|
            if grid[i][col] == " "
                valid_moves << [i, col]
            elsif grid[i][col] != piece
                valid_moves << [i, col]
                break
            else
                break
            end
        end

        # left
        (col - 1).downto(0) do |i|
            if grid[row][i] == " "
                valid_moves << [row, i]
            elsif grid[row][i] != piece
                valid_moves << [row, i]
                break
            else
                break
            end
        end

        # right
        (col + 1).upto(7) do |i|
            if grid[row][i] == " "
                valid_moves << [row, i]
            elsif grid[row][i] != piece
                valid_moves << [row, i]
                break
            else
                break
            end
        end

        valid_moves
    end

    def self.knight_moves(start, _grid)
        valid_moves = []
        row, col = start
        moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
        moves.each do |move|
            new_row = row + move[0]
            new_col = col + move[1]
            if new_row.between?(0, 7) && new_col.between?(0, 7)
                valid_moves << [new_row, new_col]
            end
        end
        valid_moves
    end

    def self.bishop_moves(start, grid)
        valid_moves = []
        row, col = start
        piece = grid[row][col]

        # up-left
        (-7..7).each do |i|
            if (row + i).between?(0, 7) && (col + i).between?(0, 7)
                if grid[row + i][col + i] == " "
                    valid_moves << [row + i, col + i]
                elsif grid[row + i][col + i] != piece
                    valid_moves << [row + i, col + i]
                    break
                else
                    break
                end
            end
        end

        # up-right
        (-7..7).each do |i|
            if (row + i).between?(0, 7) && (col - i).between?(0, 7)
                if grid[row + i][col - i] == " "
                    valid_moves << [row + i, col - i]
                elsif grid[row + i][col - i] != piece
                    valid_moves << [row + i, col - i]
                    break
                else
                    break
                end
            end
        end

        # down-Left
        (-7..7).each do |i|
            if (row - i).between?(0, 7) && (col + i).between?(0, 7)
                if grid[row - i][col + i] == " "
                    valid_moves << [row - i, col + i]
                elsif grid[row - i][col + i] != piece
                    valid_moves << [row - i, col + i]
                    break
                else
                    break
                end
            end
        end

        # down-Right
        (-7..7).each do |i|
            if (row - i).between?(0, 7) && (col - i).between?(0, 7)
                if grid[row - i][col - i] == " "
                    valid_moves << [row - i, col - i]
                elsif grid[row - i][col - i] != piece
                    valid_moves << [row - i, col - i]
                    break
                else
                    break
                end
            end
        end

        valid_moves
    end

    def self.queen_moves(start, grid)
        valid_moves = rook_moves(start, grid) + bishop_moves(start, grid)
        valid_moves
    end

    def self.king_moves(start, _grid)
        valid_moves = []
        row, col = start
        moves = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
        moves.each do |move|
            new_row = row + move[0]
            new_col = col + move[1]
            if new_row.between?(0, 7) && new_col.between?(0, 7)
                valid_moves << [new_row, new_col]
            end
        end
        valid_moves
    end

    def self.move(start,ends ,grid)
        row = start[0]
        column = start[1]
        valid_moves = []
        piece = grid[row][column]

        case piece
        when "\u2659", "\u265F" # pawn
            valid_moves = pawn_moves(start, grid)
        when "\u2656", "\u265C" # rook
            valid_moves = rook_moves(start, grid)
        when "\u2658", "\u265E" # knight
            valid_moves = knight_moves(start, grid)
        when "\u2657", "\u265D" # bishop
            valid_moves = bishop_moves(start, grid)
        when "\u2655", "\u265B" # queen
            valid_moves = queen_moves(start, grid)
        when "\u2654", "\u265A" # king
            valid_moves = king_moves(start, grid)
        else
            puts "Invalid chess piece"
        end

        if valid_moves.empty?
            puts "No valid moves available"
        elsif valid_moves.include?(ends)
            grid[ends[0]][ends[1]] = piece
            grid[row][column] = " "
        else
            puts "Invalid move"
            
        end
    end
    def self.checkmate?(grid)
        # Check if the king is in checkmate
        # This is a very simplified version and doesn't account for all rules of chess
        # It only checks if the king has any valid moves left
        ['\u2654', '\u265A'].each do |king| # white and black king
            start = grid.find_index { |row| row.include?(king) }
            if start
                col = grid[start].index(king)
                if king_moves([start, col], grid).empty?
                    return king == '\u2654' ? 'White is in checkmate' : 'Black is in checkmate'
                end
            end
        end
        false
    end

    def self.draw?(grid)
        # Check if the game is a draw
        # This is a very simplified version and doesn't account for all rules of chess
        # It only checks if there are only kings left on the board
        pieces = grid.flatten.reject { |piece| piece == " " }
        pieces.all? { |piece| ['\u2654', '\u265A'].include?(piece) } ? 'The game is a draw' : false
    end
end
