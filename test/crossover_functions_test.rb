require 'minitest/autorun'
require_relative '../lib/crossover_functions'
require_relative '../lib/chromosome'


class CrossoverTest < Minitest::Test

  def test_exists
    assert Crossover
  end

  def test_single_point_crossover
    ch1 = Chromosome.new(dna: [1,2,3])
    ch2 = Chromosome.new(dna: ["a","b","c"])

    os1, os2 = Crossover.single_point[ch1, ch2, rate: 1, cut_point: 0]

    assert_equal [1,2,3], ch1.dna
    assert_equal ["a","b","c"], ch2.dna

    assert_equal [1, "b", "c"], os1.dna
    assert_equal ["a", 2, 3], os2.dna

    assert_equal os1.fitness_score[[1,1,0]], ch1.fitness_score[[1,1,0]]
  end

end
