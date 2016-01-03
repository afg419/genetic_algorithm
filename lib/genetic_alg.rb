class GeneticAlgorithm

  attr_reader :population, :built_by, :fitness_threshold

  def initialize(opts)
    # total: ?, selection: ?, crossover: ?, fitness: ? , mutation: ?, range: ? count: ?, threshold: ?
    @population = opts[:population] || Population.new(opts)
    @fitness_threshold = opts[:threshold] || 1
    @built_by = opts
  end

  def breed_generation
    binding.pry

    parent_population = population.selection

    binding.pry

    child_population = parent_population.each_slice(2).to_a.map do |ch1, ch2|
      population.crossover(ch1,ch2)
    end.flatten

    binding.pry

    new_generation = child_population.map do |chrom|
      chrom.mutate
    end

    binding.pry

    @population.chromosomes = new_generation
  end

  def fittest_chromosome
    population.chromosomes.max_by {|chrom| chrom.fitness}
  end

  def sufficient_fitness?
    fittest_chromosome.fitness >= fitness_threshold
  end

  def evolve(n)
    n.times do
      break if sufficient_fitness?
      breed_generation
    end
    fittest_chromosome
  end
end
