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
      fitness: Fitness.euc_dist(Array.new(count, 0)),
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
      fitness: Fitness.taxi_dist(Array.new(count, 0)),
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

    sample_chrom.mutate

    sample_chrom.dna.each do |bp|
      assert (-6.0 <= bp && bp <= 6.0)
    end

    ga2 = GeneticAlgorithm.new(binary_opts(140, 30, 0))

    assert_equal 140, ga2.population.chromosomes.count

    sample_chrom = ga2.population.chromosomes.sample

    assert_equal 30, sample_chrom.dna.count

    sample_chrom.dna.each do |bp|
      assert [0,1].include?(bp)
    end

    sample_chrom.mutate

    sample_chrom.dna.each do |bp|
      assert [0,1].include?(bp)
    end
  end

  def test_ids_fittest_chromosome
    ga = GeneticAlgorithm.new(binary_opts(140, 30, 0))
    c = Chromosome.new(binary_opts(140, 30, 0).merge(dna: Array.new(30,1)))
    ga.population.chromosomes << c

    assert_equal c, ga.fittest_chromosome
  end

  def test_evolution
    good_rates = {c_rate: 0.55, m_rate: 0.03}
    good_binary_opts = binary_opts(140, 50, 50).merge(good_rates)

    5.times do
      ga = GeneticAlgorithm.new(good_binary_opts)
      init = ga.fittest_chromosome
      ga.evolve(25)
      fin = ga.fittest_chromosome
      assert_equal Array.new(50,1), fin.dna
      p "init_fit: #{init.fitness}, fin_fit: #{fin.fitness}"
    end

    second_opts = good_binary_opts.merge(fitness: Fitness.taxi_dist(Array.new(50, 1)))

    5.times do
      ga = GeneticAlgorithm.new(second_opts)
      init = ga.fittest_chromosome
      ga.evolve(25)
      fin = ga.fittest_chromosome
      assert_equal Array.new(50,0), fin.dna
      p "init_fit: #{init.fitness}, fin_fit: #{fin.fitness}"
    end

    third_opts = good_binary_opts.merge(fitness: Fitness.taxi_dist( (Array.new(25,1) + Array.new(25,0))))

    5.times do
      ga = GeneticAlgorithm.new(third_opts)
      init = ga.fittest_chromosome
      ga.evolve(25)
      fin = ga.fittest_chromosome

      assert_equal (Array.new(25,0) + Array.new(25,1)), fin.dna
      puts "fin_fit: #{fin.dna}"
    end

    fourth_opts = good_binary_opts.merge(fitness: Fitness.summation_dist( (Array.new(25,1) + Array.new(25,0)).shuffle))

    5.times do
      ga = GeneticAlgorithm.new(fourth_opts)
      init = ga.fittest_chromosome
      ga.evolve(25)
      fin = ga.fittest_chromosome

      expected = [Array.new(50,0), Array.new(50,1)]

      assert expected.include?(fin.dna)
      puts "fin_fit: #{fin.dna}"
    end

  end

  def find_best_parameters
    c_rates = (0..20).to_a.map { |x| x*5/(100.to_f) }
    m_rates = (0..10).to_a.map { |x| x/(100.to_f) }

    c_rates.each do |c|
      m_rates.each do |m|
        good_rates = {c_rate: c, m_rate: m}
        good_binary_opts = binary_opts(140, 50, 50).merge(good_rates)
        ga = GeneticAlgorithm.new(good_binary_opts)
        init = ga.fittest_chromosome.fitness
        ga.evolve(25)
        fin = ga.fittest_chromosome.fitness
        p "c_rate:#{c}, m_rate:#{m}, init_fit: #{init}, fin_fit: #{fin}"
      end
    end
  end

end
