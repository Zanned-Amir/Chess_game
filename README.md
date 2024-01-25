# Chess Game

This is a simple command-line Chess game implemented in Ruby.

## Classes

- `Player`: Represents a player in the game. Each player has a color (white or black).
- `Game`: Controls the game flow. It initializes a new board, handles player turns, checks for valid moves, and determines the game outcome (check, checkmate, or stalemate).

## Chess Board Display

The chess board is displayed in the terminal after each player's turn. The board is an 8x8 grid, with each cell representing a square on the chess board. Each piece is represented by a specific character:

- ♖, ♘, ♗, ♕, ♔, ♙ represent the white rook, knight, bishop, queen, king, and pawn respectively.
- ♜, ♞, ♝, ♛, ♚, ♟ represent the black rook, knight, bishop, queen, king, and pawn respectively.

Empty squares are represented by a blank space.

Here's an example of what the board might look like at the start of the game:
A B C D E F G H
-----------------------------------
1 | ♖ | ♘ | ♗ | ♕ | ♔ | ♗ | ♘ | ♖ | 1
-----------------------------------
2 | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | 2
-----------------------------------
3 | | | | | | | | | 3
-----------------------------------
4 | | | | | | | | | 4
-----------------------------------
5 | | | | | | | | | 5
-----------------------------------
6 | | | | | | | | | 6
-----------------------------------
7 | ♟ | ♟ | ♟ | ♟ | ♟ | ♟ | ♟ | ♟ | 7
-----------------------------------
8 | ♜ | ♞ | ♝ | ♛ | ♚ | ♝ | ♞ | ♜ | 8
-----------------------------------
A B C D E F G H

## How to Play

1. Run `game.rb` to start a new game.
2. The game will ask if you want to load a saved game or start a new one.
3. If you choose to start a new game, player 1 (white) will start.
4. Enter the coordinates of the piece you want to move (e.g., 'A1').
5. Enter the coordinates of the position you want to move to (e.g., 'E8').
6. The game will validate your move. If it's invalid, you'll need to try again.
7. The game continues to alternate turns between the two players until a checkmate or stalemate is reached.

## Save and Load Game

You can save the game at any point by typing 'save'. You can load a saved game at the beginning of a new game.

## Requirements

- Ruby

## How to Run

1. Clone this repository.
2. Navigate to the repository directory.
3. Run `ruby game.rb` to start the game.
