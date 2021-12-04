# frozen_string_literal: true

# Bingo game with the giant squid!
class Bingo
  def initialize(bingo_order, boards)
    @bingo_order = bingo_order
    @boards = boards
    @marked_elements = Hash[(0..boards.size - 1).map { |i| [i, []] }]
    @winning_value = nil
  end

  def find_first_winner_board
    bingo_order.each do |drawn_number|
      boards.each_with_index do |board, board_number|
        mark_board(board, board_number, drawn_number)

        next unless board_wins?(board_number)

        @winning_value = drawn_number
        return board_number
      end
    end
  end

  def find_last_winner_board
    bingo_order.each_with_object([]) do |drawn_number, won|
      boards.each_with_index do |board, board_number|
        next if won.include?(board_number)

        mark_board(board, board_number, drawn_number)

        next unless board_wins?(board_number)

        @winning_value = drawn_number
        won << board_number
      end
    end.last
  end

  def final_score(board)
    winning_value * sum_unmarked_elements_in_board(board)
  end

  private

  attr_reader :bingo_order, :boards, :winning_value, :marked_elements

  def board_wins?(board)
    row_grouping = marked_elements[board].group_by(&:first)
    col_grouping = marked_elements[board].group_by(&:last)

    row_grouping.any? { |_, v| v.count == 5 } ||
      col_grouping.any? { |_, v| v.count == 5 }
  end

  def mark_board(board, board_number, drawn_number)
    marked = matching_elements(board, drawn_number)

    return if marked.empty?

    marked_elements[board_number] << marked
  end

  def matching_elements(board, drawn_number)
    matching_elements = []

    board.each_with_index do |row, i|
      row.each_with_index do |element, j|
        matching_elements << [i, j] if element == drawn_number
      end
    end

    matching_elements.flatten
  end

  def sum_unmarked_elements_in_board(board)
    sum = 0

    boards[board].each_with_index do |row, i|
      row.each_with_index do |el, j|
        sum += el unless marked_elements[board].include?([i, j])
      end
    end

    sum
  end
end

def create_board(lines)
  skip = [lines.last, "\n"]
  board = []

  lines.drop(2).each_with_object([]) do |line, result|
    next(board << line.split(' ').map(&:to_i)) unless skip.include?(line)

    result << board
    board = []
  end
end

def read_input(input)
  lines = File.readlines(input)
  bingo_order = lines.first.split(',').map(&:to_i)

  [bingo_order, create_board(lines.drop(2))]
end

def part_a_score(bingo_order, boards)
  bingo = Bingo.new(bingo_order, boards)
  board = bingo.find_first_winner_board

  bingo.final_score(board)
end

def part_b_score(bingo_order, boards)
  bingo = Bingo.new(bingo_order, boards)
  board = bingo.find_last_winner_board

  bingo.final_score(board)
end

bingo_order, boards = read_input('input.txt')
puts part_a_score(bingo_order, boards)
puts part_b_score(bingo_order, boards)
