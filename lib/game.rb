require "./board.rb"
require "./chess_pieces.rb"
class Game
    def initialize
        @board = Board.new
        @current_player = "\u2654" # White King
    end

    def play
        until game_over?
            @board.display_board
            move = get_move
            ChessPieces.move(move[0], move[1], @board.grid)
            switch_player
        end
        @board.display_board
        puts game_result
    end

    private

    def get_move
    index =
        loop do
        puts "Current player: #{@current_player == "\u2654" ? 'White' : 'Black'}"
        print "Enter your move (e.g., 'A2 A3'): "
        input = gets.chomp
        index = Board.convert_to_index(input)
        break if index != nil
        puts "Invalid input"
        end
        index

    end

    def switch_player
        @current_player = @current_player == "\u2654" ? "\u265A" : "\u2654" # Switch between White and Black King
    end

    def game_over?
        ChessPieces.checkmate?(@board.grid) || ChessPieces.draw?(@board.grid)
    end

    def game_result
        if result == ChessPieces.checkmate?(@board.grid)
            result
        elsif result == ChessPieces.draw?(@board.grid)
            result
        else
            "Game is still ongoing"
        end
    end
end
game = Game.new
game.play