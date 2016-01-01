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

  def select_parents
    #fitness propotion : (old_fitness - average_fitness) / 2* sigma
    # sigma = root(variance)
    # variance = sum((f - average_fitness )**2)/total
  end

  def fitness_scaling
    #fitness proportion : (old_fitness - average_fitness) / 2* sigma
    # sigma = root(variance)
    # variance = sum((f - average_fitness )**2)/total
  end

  def average_fitness(fitness_block)
    total = chromosomes.length
    num = chromosomes.reduce(0) do |acc, chrom|
      acc + chrom.fitness(fitness_block)
    end
  end

  def variance

  end

  def crossover

  end
end


class Array

end
