require_relative 'chromosome'

class Population

  attr_reader :chromosomes

  def initialize(opts)
    @chromosomes = opts[:chromosomes] || rand_chromosomes(opts[:range], opts[:count], opts[:total], opts[:fitness])
    @selection_function = opts[:selection]
    @crossover_function = opts[:crossover]
  end

  def rand_chromosomes(range, count, total, fitness = nil)
    Array.new(total,0).map do
      Chromosome.new(count: count, range: range, fitness: fitness)
    end
  end

  def selection
    parent_population = []
    #fitness propotion : (old_fitness - average_fitness) / 2* sigma
    # sigma = root(variance)
    # variance = sum((f - average_fitness )**2)/total
  end

  def tournament_selection(n)
    parent_population = []
    total_chromosomes.times do
      parent_population << chromosomes.shuffle[0..n-1].max_by {|chrom| chrom.fitness}
    end
    parent_population
  end

  def total_chromosomes
    chromosomes.length
  end

  def crossover
    
  end

  # def fitness_scaling(chromosome)
  #   (chromosome.fitness - average_fitness)/(2*(variance ** (0.5)))
  # end
  #
  # def average_fitness
  #   num = chromosomes.reduce(0) do |acc, chrom|
  #     acc + chrom.fitness
  #   end
  #   num.to_f/total_chromosomes
  # end
  #
  # def variance
  #   chromosomes.reduce(0) do |acc, chrom|
  #     (chrom.fitness - average_fitness)**2
  #   end.to_f / total_chromosomes
  # end
  #
  # def crossover(chromosome1, chromosome2, *rates)
  #
  # end
end


class Array

end
