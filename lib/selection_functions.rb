module Selection
  #opts requires a value n: 5 to rep size of pop to consider.
  def self.tournament
    Proc.new do |chromosomes, opts|
      chromosomes.map do
        chromosomes.shuffle[0..opts[:n]-1].max_by {|chrom| chrom.fitness}
      end
    end
  end



  #fitness propotion : (old_fitness - average_fitness) / 2* sigma
  # sigma = root(variance)
  # variance = sum((f - average_fitness )**2)/total


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
