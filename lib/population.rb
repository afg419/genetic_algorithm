require_relative 'chromosome'
require_relative 'crossover_functions'
require_relative 'selection_functions'

class Population
  attr_reader :chromosomes, :selection_mechanic, :crossover_combinator

  def initialize(opts)
    @chromosomes = opts[:chromosomes] || rand_chromosomes(opts)
    @selection_mechanic = opts[:selection] || Selection.tournament
    @crossover_combinator = opts[:crossover]
  end

  def rand_chromosomes(opts)
    Array.new(opts[:total],0).map do
      Chromosome.new(opts)
    end
  end

  def selection(opts = {})
    selection_mechanic[chromosomes, opts]
  end

  def crossover(chrom1, chrom2, opts = {})
    crossover_combinator[chrom1, chrom2, opts]
  end
end
