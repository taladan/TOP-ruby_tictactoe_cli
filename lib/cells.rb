# get_cell.rb

module Cells
  def get_cell(choice)
    case choice
    when 'a0'
      [0, 0]
    when 'a1'
      [0, 1]
    when 'a2'
      [0, 2]
    when 'b0'
      [1, 0]
    when 'b1'
      [1, 1]
    when 'b2'
      [1, 2]
    when 'c0'
      [2, 0]
    when 'c1'
      [2, 1]
    when 'c2'
      [2, 2]
    end
  end

  def playable?(matrix, cell)
    matrix[cell[0], cell[1]] == ' '
  end

  def input_valid?(choice)
    !!(choice =~ /^[a-c][0-2]$/i)
  end
end
