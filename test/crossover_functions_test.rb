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

    os1, os2 = Crossover.single_point[ch1, ch2, rate: 1, cut_point: 1]

    assert_equal [1,2,3], ch1.dna
    assert_equal ["a","b","c"], ch2.dna

    assert_equal [1, "b", "c"], os1.dna
    assert_equal ["a", 2, 3], os2.dna

    assert_equal os1.fitness_score[[1,1,0]], ch1.fitness_score[[1,1,0]]
  end

  def test_single_point_crossover_different_cut_different_rate
    ch1 = Chromosome.new(dna: [1,2,3])
    ch2 = Chromosome.new(dna: ["a","b","c"])

    os1, os2 = Crossover.single_point[ch1, ch2, rate: 1, cut_point:2]

    assert_equal [1, 2, "c"], os1.dna
    assert_equal ["a", "b", 3], os2.dna

    os1, os2 = Crossover.single_point[ch1, ch2, rate: 0, cut_point:2]

    assert_equal ch1.dna, os1.dna
    assert_equal ch2.dna, os2.dna
  end

  def test_random_rate_crossover
    ch1 = Chromosome.new(dna: [1,2,3])
    ch2 = Chromosome.new(dna: ["a","b","c"])

    os1, os2 = Crossover.random_rate[ch1, ch2, rate: 1]

    assert_equal ["a","b","c"], os1.dna
    assert_equal ["a","b","c"], ch2.dna
    assert_equal [1,2,3], os2.dna
    assert_equal [1,2,3], ch1.dna

    os1, os2 = Crossover.random_rate[ch1, ch2, rate: 0]

    assert_equal ["a","b","c"], os2.dna
    assert_equal ["a","b","c"], ch2.dna
    assert_equal [1,2,3], os1.dna
    assert_equal [1,2,3], ch1.dna
  end

end
