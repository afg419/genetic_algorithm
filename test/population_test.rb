require 'minitest/autorun'
require_relative '../lib/population'

class PopulationTest < Minitest::Test

  def test_exists
    assert Population
  end

  def test_inits_with_given_chromosomes
    c = Chromosome.new(dna: [1,2,3,4])
    chromosomes = Array.new(10,0).map do
      c
    end
    pop = Population.new(chromosomes: chromosomes)

    assert_equal 10, pop.chromosomes.length
    pop.chromosomes.each do |chromo|
      assert_equal [1,2,3,4], chromo.dna
    end
  end

  def test_inits_with_random_chromosomes
    pop = Population.new(total: 6, range: (-1.0..1.0), count: 5)

    assert_equal 6, pop.chromosomes.length

    pop.chromosomes.each do |chromo|
      assert_equal 5, chromo.dna.length

      chromo.dna.each do |bp|
        assert -1 <= bp && bp <= 1
      end
    end
  end

end
