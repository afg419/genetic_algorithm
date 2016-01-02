require_relative 'chromosome'
require_relative 'crossover_functions'
require_relative 'selection_functions'

class Population
  attr_reader :chromosomes, :selection_mechanic, :crossover_combinator, :built_by

  def initialize(opts)
    @chromosomes = opts[:chromosomes] || rand_chromosomes(opts)
    @selection_mechanic = opts[:selection]
    @crossover_combinator = opts[:crossover]
    @built_by = opts
  end

  def rand_chromosomes(opts)
    Array.new(opts[:total],0).map do
      Chromosome.new(opts)
    end
  end

  def selection
    selection_mechanic[chromosomes, built_by]
  end

  def crossover(chrom1, chrom2)
    crossover_combinator[chrom1, chrom2, built_by]
  end
end
