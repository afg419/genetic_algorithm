require 'minitest/autorun'
require_relative '../lib/genetic_alg'
require_relative '../lib/population'

class GeneticAlgorithmTest < Minitest::Test

  def neural_opts(total, count, range, threshold)
    {
      total: total,
      count: count,
      range: range,
      threshold: threshold,
      selection: Selection.tournament,
      n: 10,
      crossover: Crossover.random_rate,
      c_rate: 1,
      fitness: Fitness.euc_dist(Array.new(count,0)),
      mutation: Mutation.add_rand,
      m_rate: 1,
      m_max: 5
    }
  end

  def binary_opts(total, count, threshold)
    {
      total: total,
      count: count,
      range: (0..1),
      threshold: threshold,
      selection: Selection.tournament,
      n: 10,
      crossover: Crossover.single_point,
      c_rate: 1,
      fitness: Fitness.taxi_dist(Array.new(count,0)),
      mutation: Mutation.bit_flip,
      m_rate: 1
    }
  end

  def test_exists
    assert GeneticAlgorithm
  end

  def test_initializes_with_given_population
    c1 = Chromosome.new(dna:[0,1,1])
    c2 = Chromosome.new(dna:[1,0,1])
    c3 = Chromosome.new(dna:[1,1,1])
    c4 = Chromosome.new(dna:[0,0,1])

    pop = Population.new(chromosomes: [c1,c2,c3,c4], crossover: Crossover.random_rate)

    ga = GeneticAlgorithm.new(population: pop, threshold: 5)

    assert_equal pop, ga.population
    assert_equal 5, ga.fitness_threshold
  end

  def test_initializes_with_population_according_to_opts
    ga1 = GeneticAlgorithm.new(neural_opts(140, 30, (-1.0..1.0), 0))

    assert_equal 140, ga1.population.chromosomes.count

    sample_chrom = ga1.population.chromosomes.sample

    assert_equal 30, sample_chrom.dna.count
    sample_chrom.dna.each do |bp|
      assert -1 <= bp && bp <= 1
    end

    sample_chrom.mutate(ga1.built_by)

    sample_chrom.dna.each do |bp|
      assert (-6.0 <= bp && bp <= 6.0)
    end

    ga2 = GeneticAlgorithm.new(binary_opts(140, 30, 0))


  end

end
