require_relative "board.rb"
class Player
    def initialize(color)
        @color = color
    end
end
class Game

    def initialize
        @board = Board.new
        
    end
    def play
        input =""
        final =[]
        start =[]
        valide_move =[]
        puts"welcome to chess game"
       @board.display_board
       loop do
            puts" player 1  your turn color white"
            loop do
                loop do
                    puts "Enter the coordinates of the piece you want to move e.g 'A1' or 'exit' to quit"
                    input = gets.chomp
                    start = Board.convert_to_index(input)
                    valide_move = @board.valide_move(start)
                    break if  Board.convert_to_index(input) != nil && @board.white_listed.include?(@board.grid[start[0]][start[1]]) && valide_move != []
                    puts "invalid place"
                end 
                loop do 
                    puts   "Enter the coordinates of the position you want to move to e.g 'E8' or 'exit' to quit"
                    input = gets.chomp
                    final = Board.convert_to_index(input)
                    valide_move = @board.valide_move(start)
                    if valide_move.include?(final)
                        @board.move(start,final)
                    end
                    break if  Board.convert_to_index(input) != nil && valide_move.include?(final)
                    puts "invalid move"     
                end
                break if  @board.check?("white") == false
                puts "white king still in check !"
                @board.reset_last_move(start,final)
            end
            begin

            @board.display_board

            if @board.checkmate?("black")
                puts "checkmate !!!"
                puts "white win"
                break 
            elsif @board.check?("black") 
                puts "black king is in check ! choose right piece"
            end

            puts" player 2  your turn color black"
            loop do
                loop do
                    puts "Enter the coordinates of the piece you want to move e.g 'A1' or 'exit' to quit"
                    input = gets.chomp
                    start = Board.convert_to_index(input)
                    valide_move = @board.valide_move(start)
                    break if  Board.convert_to_index(input) != nil && @board.black_listed.include?(@board.grid[start[0]][start[1]]) && valide_move != []
                    puts "invalid place"
                end
                loop do 
                    puts   "Enter the coordinates of the position you want to move to e.g 'E8' or 'exit' to quit"
                    input = gets.chomp
                    final = Board.convert_to_index(input)
                    valide_move = @board.valide_move(start)
                    if valide_move.include?(final)
                        @board.move(start,final)
                    end
                    break if  Board.convert_to_index(input) != nil && valide_move.include?(final)
                    puts "invalid move"
                end
                break if  @board.check?("black") == false
                puts "black king still in check ! choose right piece"
                @board.reset_last_move(start,final)
            end
            @board.display_board
            if  @board.checkmate?("white")
                puts "checkmate"
                puts "black win"
                break
            elsif @board.check?("white")
                puts "white king is in check"   
            end
        end
        rescue RuntimeError => e
            puts e.message
        end




    end 
                                          

end
game = Game.new
game.play  
