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
    c = Chromosome.new(dna: [1,2,3,1], fitness: Proc.new {|dna| dna.length})
    assert_equal 4, c.fitness
  end

  def test_bit_flip
    c = Chromosome.new(dna: [])

    assert_equal 1, c.bit_flip["_",0]
    assert_equal 0, c.bit_flip["_",1]
  end

  def test_bit_flip_mutation
    c = Chromosome.new(dna: [1,0,0,1,0])
    c.mutate(1.5,6,c.bit_flip)

    assert_equal [0,1,1,0,1], c.dna

    c.mutate(0,6,c.bit_flip)

    assert_equal [0,1,1,0,1], c.dna

    c.mutate(0.5,6,c.bit_flip)

    p c.dna
    c.dna.each do |bp|
      assert [1,0].include?(bp)
    end
  end

  def test_add_rand
    c = Chromosome.new(dna: [])

    10.times do
      r = c.add_rand[10,0]
      assert -10 <= r && r <= 10
    end
  end

  def test_add_rand_mutation
    c = Chromosome.new(dna: [0,0,0,0,0])
    c.mutate(1.5, 5, c.add_rand)

    c.dna.each do |bp|
      refute bp == 0
      assert -5 <= bp && bp <= 5
    end

    c = Chromosome.new(dna: [1,1,1,1,1])
    c.mutate(1.5, 5 , c.add_rand)
    c.dna.each do |bp|
      refute bp == 1
      assert -6 <= bp && bp <= 6
    end

    c = Chromosome.new(dna: [0,0,0,0,0])
    c.mutate(0, 5, c.add_rand)
    c.dna.all? {|bp| bp == 0}
  end

  def test_dist_from_all_ones
    c = Chromosome.new(dna: [1,1,0,1,0], fitness: FitnessFunctions::dist_to_ones)
    assert_equal 2, c.fitness
  end
end
