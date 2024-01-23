require "./lib/board.rb"

describe Board do
    describe "convert_to_index" do
        it "returns [0, 0] for A1" do
            expect(Board.convert_to_index("A1")).to eql([0, 0])
        end
        it "returns [7, 7] for H8" do
            expect(Board.convert_to_index("H8")).to eql([7, 7])
        end
        it "returns nil for aa" do
            expect(Board.convert_to_index("aa")).to eql(nil)
        end
    end

    describe "valide_move_pawnes" do
        it "returns [[5,0],[4,0]] for [6,0]" do
            board = Board.new
            board.grid[6][0] = "\u2659"
            expect(board.valide_move_pawnes([6,0])).to eql([[5,0],[4,0]])
        end
    end

    describe "valide_move_knight" do
        it "returns [ [5, 1], [5, 5], [3, 1], [3, 5], [2, 2], [2, 4] ] for [4,3]" do
            board = Board.new
            board.grid[4][3] = "\u2658E"
            expect(board.valide_move_knight([4,3])).to eql([ [5, 1], [5, 5], [3, 1], [3, 5], [2, 2], [2, 4] ])
        end
        it "returns [[4, 5], [3, 6]] for [5,7]" do
            board = Board.new
            board.grid[5][7] = "\u265E"
        
            expect(board.valide_move_knight([5,7])).to eql([[4, 5], [3, 6]])
        end
        it "returns [] for [0,9]" do
            board = Board.new
            expect(board.valide_move_knight([0,9])).to eql([])
        end
    end
    describe "valide_move_rook" do
        it "returns [[2, 1], [2, 0], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7], [3, 2], [4, 2], [5, 2], [6, 2], [7, 2], [1, 2], [0, 2]] for [2,2]" do
        board = Board.new
        board.grid[2][2] = "\u2656"
        expect(board.valide_move_rook([2,2])).to eql([[2, 1], [2, 0], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7], [3, 2], [4, 2], [5, 2], [6, 2], [7, 2], [1, 2], [0, 2]])
        end
        it "returns [[5, 7], [5, 6], [5, 5], [5, 4], [5, 3], [5, 1], [5, 0], [4, 7], [3, 7], [2, 7], [1, 7], [0, 7], [6, 7], [7, 7]] for [5,7]" do
            board = Board.new
            board.grid[5][7] = "\u265C"
            expect(board.valide_move_rook([5,7])).to eql([[5, 6], [5, 5], [5, 4], [5, 3], [5, 1], [5, 0], [4, 7], [3, 7], [2, 7], [1, 7], [0, 7], [6, 7], [7, 7]])
        end
        it  "it returns [[3, 2], [4, 2], [2, 3], [2, 0], [2, 1]] for [2,2]" do
            board = Board.new
            board.grid[2][2]="\u2656"
            board.grid[2][4]="\u2656"
            board.grid[4][2]="\u265E"
            expect(board.valide_move_rook([2,2])).to eql([[3, 2], [4, 2], [2, 3], [2, 0], [2, 1]])
        end
        
    end
    describe "valide_move_bishop" do
        it "returns [[3,1],[4,2],[5,3],[6,4]] for [2,2]" do
            board = Board.new
            board.grid[2][2] = "\u2657"
            expect(board.valide_move_bishop([2,2])).to eql([[3,1],[4,2],[5,3],[6,4]])
        end
    end
end


