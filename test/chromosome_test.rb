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


end
