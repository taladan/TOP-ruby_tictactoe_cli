# board_spec.rb
require 'matrix'
require './lib/board'

describe Board do
  describe '#initialize' do
    # no need to test initialize when we're only setting instance variables
  end

  describe '#draw_board' do
    # printing and putting info is already well tested in ruby
  end

  # Check the game state to see if it's finished
  describe '#game_over' do
    subject(:ttt_game) { described_class.new('player1', 'player2', board_matrix) }

    # test every win condition

    context 'when the top row is all the same' do
      let(:board_matrix) { Matrix[%w[X X X], [' ', ' ', ' '], [' ', ' ', ' ']] }
      it 'should be game over' do
        expect(subject.game_over?).to eq true
      end
    end

    context 'when the middle row is all the same' do
      let(:board_matrix) { Matrix[[' ', ' ', ' '], %w[X X X], [' ', ' ', ' ']] }
      it 'should be game over' do
        expect(subject.game_over?).to eq true
      end
    end

    context 'when the bottom row is all the same' do
      let(:board_matrix) { Matrix[[' ', ' ', ' '], [' ', ' ', ' '], %w[X X X]] }
      it 'should be game over' do
        expect(subject.game_over?).to eq true
      end
    end

    context 'when the left column is all the same' do
      let(:board_matrix) { Matrix[['X', ' ', ' '], ['X', ' ', ' '], ['X', ' ', ' ']] }
      it 'should be game over' do
        expect(subject.game_over?).to eq true
      end
    end

    context 'when the middle column is all the same' do
      let(:board_matrix) { Matrix[[' ', 'X', ' '], [' ', 'X', ' '], [' ', 'X', ' ']] }
      it 'should be game over' do
        expect(subject.game_over?).to eq true
      end
    end

    context 'when the right column is all the same' do
      let(:board_matrix) { Matrix[[' ', ' ', 'X'], [' ', ' ', 'X'], [' ', ' ', 'X']] }
      it 'should be game over' do
        expect(subject.game_over?).to eq true
      end
    end

    context 'when the descending diagonal is all the same' do
      let(:board_matrix) { Matrix[['X', ' ', ' '], [' ', 'X', ' '], [' ', ' ', 'X']] }
      it 'should be game over' do
        expect(subject.game_over?).to eq true
      end
    end

    context 'when the ascending diagonal is all the same' do
      let(:board_matrix) { Matrix[[' ', ' ', 'X'], [' ', 'X', ' '], ['X', ' ', ' ']] }
      it 'should be game over' do
        expect(subject.game_over?).to eq true
      end
    end

    context 'when the board is full' do
      let(:board_matrix) { Matrix[%w[X O X], %w[O X O], %w[O X O]] }
      it 'should be game over' do
        expect(subject.game_over?).to eq true
      end
    end

    # Test all possible combos of rows/cols/diags NOT being equal - all should be false

    context 'when the top row is not the same' do
      let(:board_matrix) { Matrix[%w[X O X], [' ', ' ', ' '], [' ', ' ', ' ']] }
      it 'should not be game over' do
        expect(subject.game_over?).to eq false
      end
    end

    context 'when the middle row is not the same' do
      let(:board_matrix) { Matrix[[' ', ' ', ' '], %w[X O X], [' ', ' ', ' ']] }
      it 'should not be game over' do
        expect(subject.game_over?).to eq false
      end
    end

    context 'when the bottom row is not the same' do
      let(:board_matrix) { Matrix[[' ', ' ', ' '], [' ', ' ', ' '], %w[X O X]] }
      it 'should not be game over' do
        expect(subject.game_over?).to eq false
      end
    end

    context 'when the left column is not the same' do
      let(:board_matrix) { Matrix[['X', ' ', ' '], ['O', ' ', ' '], ['X', ' ', ' ']] }
      it 'should not be game over' do
        expect(subject.game_over?).to eq false
      end
    end

    context 'when the middle column is not the same' do
      let(:board_matrix) { Matrix[[' ', 'O', ' '], [' ', 'X', ' '], [' ', 'O', ' ']] }
      it 'should not be game over' do
        expect(subject.game_over?).to eq false
      end
    end

    context 'when the right column is not the same' do
      let(:board_matrix) { Matrix[[' ', ' ', 'X'], [' ', ' ', 'O'], [' ', ' ', 'X']] }
      it 'should not be game over' do
        expect(subject.game_over?).to eq false
      end
    end

    context 'when the top left to bottom right diagonal is not the same' do
      let(:board_matrix) { Matrix[['X', ' ', ' '], [' ', ' O', ' '], [' ', ' ', 'X']] }
      it 'should not be game over' do
        expect(subject.game_over?).to eq false
      end
    end

    context 'when the bottom left to top right diagonal is not the same' do
      let(:board_matrix) { Matrix[[' ', ' ', 'X'], [' ', 'O', ' '], ['X', ' ', ' ']] }
      it 'should not be game over' do
        expect(subject.game_over?).to eq false
      end
    end
  end

  # let player place piece on board
  describe '#play_piece' do
    require 'player'

    # Board set up
    subject(:ttt_game) { described_class.new('player1', 'player2', board_matrix) }
    let(:player1) { Player.new('Player1', 'X') }
    let(:player2) { Player.new('Player2', 'O') }
    let(:board_matrix) { Matrix[[' ', 'X', ' '], [' ', ' ', ' '], [' ', ' ', ' ']] }

    context 'when a player adds a piece to an empty slot' do
      let(:choice) { 'a0' }
      it 'should have X in cell[0,0]' do
        allow(ttt_game).to receive(:gets).and_return(choice)

        ttt_game.play_piece(player1)
        expect(ttt_game.board_matrix[0, 0]).to eq('X')
      end
    end
  end
end
