defmodule IslandsEngine.Main do

  alias IslandsEngine.{Game, Board, Coordinate, Island, Player}

  def run() do

    # Init Board
    {:ok, board} = Board.start_link

    # Set up Island
    {:ok, island} = Island.start_link
    a1 = Board.get_coordinate(board, :a1)
    Island.replace_coordinates(island, [a1])

    IO.puts Board.to_string(board)
    IO.puts Island.to_string(island)

    # Mark :a1 as :my_island
    Board.set_coordinate_in_island(board, :a1, :my_island)

    IO.puts Board.to_string(board)
    IO.puts Island.to_string(island)

    # Guess the coord
    Board.guess_coordinate(board, :a1)
    IO.puts Board.to_string(board)

  end

  def run_game() do
    {:ok, game} = Game.start_link("Frank")

    Game.set_island_coordinates(game, :player1, :dot, [:a1])

    state = Game.get_state(game)

    Game.set_island_coordinates(game, :player1, :dot, [:b3])

    IO.puts(Player.to_string(state.player1))

  end


end


