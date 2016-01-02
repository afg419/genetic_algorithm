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
      assert Chromosome, chromo.class
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

  def test_initializes_with_tournament_selection_by_default
    c1 = Chromosome.new(dna:[0,1,1])
    c2 = Chromosome.new(dna:[1,0,1])
    c3 = Chromosome.new(dna:[1,1,1])
    c4 = Chromosome.new(dna:[0,0,1])

    pop = Population.new(chromosomes: [c1,c2,c3,c4])

    assert_equal Proc, pop.selection_mechanic.class
    assert_equal Array.new(4,[1,1,1]), pop.selection(n:5).map{|x| x.dna}
  end

  def test_initializes_with_given_selection_mechanic
    c1 = Chromosome.new(dna:[0,1,1])
    c2 = Chromosome.new(dna:[1,0,1])
    c3 = Chromosome.new(dna:[1,1,1])
    c4 = Chromosome.new(dna:[0,0,1])

    id_selector = Proc.new {|chromosomes, opts|
      chromosomes
    }

    pop = Population.new(chromosomes: [c1,c2,c3,c4], selection: id_selector)
    assert pop.chromosomes, pop.selection
  end

  def test_initializes_with_single_point_crossover_by_default
    c1 = Chromosome.new(dna:[0,1,1])
    c2 = Chromosome.new(dna:[1,0,1])
    c3 = Chromosome.new(dna:[1,1,1])
    c4 = Chromosome.new(dna:[0,0,1])

    pop = Population.new(chromosomes: [c1,c2,c3,c4])

    os1, os2 = pop.crossover( c1, c2, rate: 1, cut_point:1 )
    e1, e2 = [0,0,1], [1,1,1]

    assert_equal e1, os1.dna
    assert_equal e2, os2.dna
  end

  def test_initializes_with_given_crossover_combinator
    c1 = Chromosome.new(dna:[0,1,1])
    c2 = Chromosome.new(dna:[1,0,1])
    c3 = Chromosome.new(dna:[1,1,1])
    c4 = Chromosome.new(dna:[0,0,1])

    pop = Population.new(chromosomes: [c1,c2,c3,c4], crossover: Crossover.random_rate)

    os1, os2 = pop.crossover( c1, c2, rate: 1)
    e1, e2 = [1,0,1], [0,1,1]

    assert_equal e1, os1.dna
    assert_equal e2, os2.dna
  end

end
