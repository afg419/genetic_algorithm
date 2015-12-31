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

  def mutate(mutate_rate, mutate_max)
    dna.map! do |bp|
      s = rand(0.0 .. 1.0)
      yield(bp) if s < mutate_rate
    end
  end

  def bit_flip
    lambda do |bp|
      if bp == 0
        1
      elsif bp == 1
        0
      end
    end
  end

end
