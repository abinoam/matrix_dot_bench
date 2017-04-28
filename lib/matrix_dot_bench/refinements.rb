require 'nmatrix'

module MatrixDotBench
  module Refinements
    refine NMatrix do
      def >(other)
        new_matrix = NMatrix.new([rows, cols], dtype: :float64)

        each_with_indices do |value, row, col|
          new_matrix[row, col] = (value > other[row, col] ? 1.0 : 0.0)
        end
        new_matrix
      end

      def custom_iterative_dot(other)
        result = NMatrix.new([rows, other.cols], dtype: :float64)
        0.upto(rows-1) do |row_number|
          0.upto(other.cols-1) do |col_number|
            product = 0.0
            0.upto(cols-1) do |ix|
              product += (self[row_number, ix]*other[ix, col_number])
            end
            result[row_number, col_number] = product
          end
        end
        result
      end

      def custom_iterative_dot_with_whiles(other)
        result = NMatrix.new([rows, other.cols], dtype: :float64)
        row_number = 0
        while(row_number<rows)
          col_number = 0
          while(col_number<other.cols)
            product = 0.0
            ix = 0
            while(ix<cols)
              product += (self[row_number, ix]*other[ix, col_number])
              ix += 1
            end
            result[row_number, col_number] = product
            col_number += 1
          end
          row_number += 1
        end
        result
      end
    end

    refine Array do
      def dot(other)
        rows = size
        cols = self[0].size
        other_cols = other[0].size
        result = Array.new(rows) { Array.new(other_cols) }
        row_number = 0
        while(row_number<rows)
          col_number = 0
          while(col_number<other_cols)
            product = 0.0
            ix = 0
            while(ix<cols)
              product += (self[row_number][ix]*other[ix][col_number])
              ix += 1
            end
            result[row_number][col_number] = product
            col_number += 1
          end
          row_number += 1
        end
        result
      end
    end
  end
end