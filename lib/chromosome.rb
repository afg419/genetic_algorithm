class Chromosome

  attr_reader :dna

  def initialize(opts) #
    @dna = opts[:dna] || rand_dna(opts[:range], opts[:count])
  end

  def rand_dna(range, n)
    Array.new(n,0).map do |elt|
      rand(range.first..range.last)
    end
  end

end
