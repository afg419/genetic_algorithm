require 'minitest/autorun'
require_relative '../lib/selection_functions'
require_relative '../lib/chromosome'


class SelectionTest < Minitest::Test

  def test_exists
    assert Selection
  end

  def test_tournament_selection
    c1 = Chromosome.new(dna: [1,1,1,1,1])
    c2 = Chromosome.new(dna: [1,1,1,1,1])
    c3 = Chromosome.new(dna: [1,1,1,1,1])
    c4 = Chromosome.new(dna: [1,0,0,1,0])
    c5 = Chromosome.new(dna: [1,0,0,1,0])

    chromosomes = [c1,c2,c3,c4,c5]
    opts = {n: 3}
    expected = Array.new(5,[1,1,1,1,1])
    computed =  Selection.tournament[chromosomes,opts].map do |chrom|
      chrom.dna
    end

    assert_equal expected, computed
  end

end
