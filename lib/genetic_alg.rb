class GeneticAlgorithm

  attr_reader :population

  def initialize(opts)
    @population = opts[:population] || Population.new(opts[:range], opts[:count], opts[:total])
  end
end
