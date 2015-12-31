require_relative 'chromosome'

class Population

  attr_reader :chromosomes

  def initialize(opts)
    @chromosomes = opts[:chromosomes] || rand_chromosomes(opts[:range], opts[:count], opts[:total])
  end

  def rand_chromosomes(range, count, total)
    Array.new(total,0).map do
      Chromosome.new(count: count, range: range)
    end
  end
end
