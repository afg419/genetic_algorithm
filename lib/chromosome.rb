require_relative 'fitness_functions'
require_relative 'mutation_functions'

class Chromosome
  attr_reader :dna, :fitness_score, :mutation_type

  def initialize(opts) # dna or range and count is minimal
    @dna = opts[:dna] || rand_dna(opts[:range], opts[:count])
    @fitness_score = opts[:fitness] || Fitness.taxi_dist(Array.new(dna.length,0))
    @mutation_type = opts[:mutation] || Mutation.bit_flip
  end

  def rand_dna(range, n)
    Array.new(n,0).map do |elt|
      rand(range.first..range.last)
    end
  end

  def mutate(opts = {rate: 0})
    dna.map! do |bp|
      s = rand(0.0 .. 1.0)
      if s < opts[:rate]
        mutation_type[bp, opts]
      else
        bp
      end
    end
  end

  def fitness
    fitness_score[dna]
  end
end
