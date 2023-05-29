# cells_spec.rb
require 'matrix'
require './lib/cells'

describe Cells do
  let(:dummy_class) { Class.new { extend Cells } }

  describe '#playable?' do
    context 'when passing a playable square' do
      let(:matrix) { Matrix[[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']] }

      it 'returns true' do
        expect(dummy_class.playable?(matrix, [0, 0])).to be true
      end
    end

    context 'when passing an unplayable square' do
      let(:matrix) { Matrix[['X', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']] }

      it 'returns false' do
        expect(dummy_class.playable?(matrix, [0, 0])).to be false
      end
    end
  end

  describe '#input_valid?' do
    context 'when passing valid input' do
      it 'returns true' do
        input = 'a0'
        expect(dummy_class.input_valid?(input)).to eq(true)
      end
    end

    context 'when passing invalid input' do
      it 'returns false' do
        input = 'a9'
        expect(dummy_class.input_valid?(input)).to eq(false)
      end
    end
  end
end
