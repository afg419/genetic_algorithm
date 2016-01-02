class GeneticAlgorithm

  attr_reader :population, :built_by, :fitness_threshold

  def initialize(opts)
    # total: ?, selection: ?, crossover: ?, fitness: ? , mutation: ?, range: ? count: ?, threshold: ?
    @population = opts[:population] || Population.new(opts)
    @fitness_threshold = opts[:threshold] || 1
    @built_by = opts
  end

  def breed_generation(opts)
    parent_population = population.selection(opts)

    child_population = parent_population.each_slice(2).to_a.map do |ch1, ch2|
      population.crossover(ch1,ch2,opts)
    end.flatten

    new_generation = child_population.map do |chrom|
      chrom.mutate(opts)
    end

    @population = Population.new(@population.built_by.merge(chromosomes: new_generation))
  end

  def fittest_chromosome
    population.chromosomes.max_by {|chrom| chrom.fitness}
  end

  def perfect_fitness?
    fittest_chromosome >= fitness_threshold
  end

  def run(n, opts)
    n.times do
      break if perfect_fitness?
      breed_generation(opts)
    end
    fittest_chromosome
  end
end
