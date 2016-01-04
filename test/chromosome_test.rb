require_relative '../lib/chromosome'
require 'minitest/autorun'

class ChromosomeTest < Minitest::Test

  def test_exists
    assert Chromosome
  end

  def test_initializes_with_given_dna
    c = Chromosome.new(dna: [1,2,3,4])
    assert_equal [1,2,3,4], c.dna
  end

  def test_initializes_with_random_dna
    c = Chromosome.new(range: (1.0..5.0), count: 6)
    assert_equal 6, c.dna.count

    c.dna.each do |bp|
      assert 1 <= bp && bp <= 5
    end
  end

  def test_initializes_with_fitness_function
    c = Chromosome.new(dna: [1,2,3,1], fitness: Fitness.euc_dist([0,3,2,1]))
    assert_equal 3**(0.5), c.fitness
  end

  def test_initializes_with_taxi_dist_to_origin_by_default
    c = Chromosome.new(dna: [1,1])
    assert_equal 2, c.fitness
  end


  def test_initializes_with_mutation_function
    c = Chromosome.new(dna: [], mutation: Mutation.add_rand)

    10.times do
      x = c.mutation_type[1, m_max: 5]
      assert -4 <= x && x <= 6
    end
  end

  def test_initializes_with_bit_flip_mutation_by_default
    c = Chromosome.new(dna: [])

    assert_equal 0 , c.mutation_type[1]
    assert_equal 1 , c.mutation_type[0]
  end

  def test_bit_flip_mutation
    c = Chromosome.new(dna: [1,0,0,1,0], m_rate: 1)
    c.mutate

    assert_equal [0,1,1,0,1], c.dna

    c = Chromosome.new(dna: [1,0,0,1,0], m_rate: 0)
    c.mutate

    assert_equal [1,0,0,1,0], c.dna

    c = Chromosome.new(dna: [1,0,0,1,0], m_rate: 0.5)
    c.mutate

    c.dna.each do |bp|
      assert [1,0].include?(bp)
    end
  end

  def test_add_rand_mutation
    c = Chromosome.new(dna: [0,0,0,0,0], mutation: Mutation.add_rand, m_rate: 1.5, m_max: 5)
    c.mutate

    c.dna.each do |bp|
      refute bp == 0
      puts bp
      assert -5 <= bp && bp <= 5
    end

    c = Chromosome.new(dna: [1,1,1,1,1], mutation: Mutation.add_rand, m_rate: 1.5, m_max: 5)
    c.mutate

    c.dna.each do |bp|
      refute bp == 1
      puts bp
      assert -6 <= bp && bp <= 6
    end

    c = Chromosome.new(dna: [0,0,0,0,0], mutation: Mutation.add_rand, m_rate: 0, m_max: 5)
    c.mutate
    c.dna.all? do |bp|
      bp == 0
    end
  end
end
