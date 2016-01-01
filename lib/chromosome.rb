require_relative 'fitness_functions'

class Chromosome
  attr_reader :dna, :fitness_function

  def initialize(opts) #
    @dna = opts[:dna] || rand_dna(opts[:range], opts[:count])
    @fitness_function = opts[:fitness]
  end

  def rand_dna(range, n)
    Array.new(n,0).map do |elt|
      rand(range.first..range.last)
    end
  end

  def mutate(mutate_rate, mutate_max, mutation_block)
    dna.map! do |bp|
      s = rand(0.0 .. 1.0)
      if s < mutate_rate
        mutation_block[mutate_max, bp]
      else
        bp
      end
    end
  end

  def fitness
    fitness_function[dna]
  end

  def bit_flip
   Proc.new do |_, bp|
      if bp == 0
        1
      elsif bp == 1
        0
      end
    end
  end

  def add_rand
    Proc.new do |mutate_max, bp|
      bp + rand(-1.0..1.0) * mutate_max
    end
  end
end
