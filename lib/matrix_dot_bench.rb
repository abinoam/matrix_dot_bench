require "matrix_dot_bench/version"
require "matrix_dot_bench/refinements"
require 'benchmark/ips'
require 'matrix'
require 'nmatrix'

using MatrixDotBench::Refinements

module MatrixDotBench
  def self.benchmark
    shape_1 = [10, 20]
    shape_2 = [20, 15]
    a1 = Array.new(shape_1[0]) { Array.new(shape_1[1]) { rand } }
    a2 = Array.new(shape_2[0]) { Array.new(shape_2[1]) { rand } }
    nm1 = NMatrix[*a1, dtype: :object]
    nm2 = NMatrix[*a2, dtype: :object]
    float64_nm1 = NMatrix[*a1, dtype: :float64]
    float64_nm2 = NMatrix[*a2, dtype: :float64]
    m1 = Matrix[*a1]
    m2 = Matrix[*a2]

    assert_all_equal(
      nm1.dot(nm2),
      float64_nm1.dot(float64_nm2),
      nm1.custom_iterative_dot(nm2),
      nm1.custom_iterative_dot_with_whiles(nm2),
      a1.dot(a2),
      m1 * m2
    )

    Benchmark.ips do |x|
      x.report(:NMatrix_dot_untyped) { nm1.dot(nm2) }
      x.report(:NMatrix_dot_float64) { float64_nm1.dot(float64_nm2) }
      x.report(:MRI_Matrix_dot) { m1 * m2 }
      x.report(:Array_custom_dot) { a1.dot(a2) }
      x.report(:NMatrix_custom_iterative_dot) { nm1.custom_iterative_dot(nm2) }
      x.report(:NMatrix_custom_dot_untyped) { nm1.custom_iterative_dot_with_whiles(nm2) }
      x.report(:NMatrix_custom_dot_float64) { float64_nm1.custom_iterative_dot_with_whiles(float64_nm2) }
      x.compare!
    end
  end

  def self.assert_all_equal(first, *args)
    args.each do |other|
      if first.to_a != other.to_a
        puts "Not all calculations results the same"
        pp [first] + args
        raise "Calculations results mismatch"
      end
    end
  end
end
