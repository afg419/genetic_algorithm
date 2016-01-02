module Crossover
  def self.single_point
    Proc.new do |ch1, ch2, opts|
      if rand(0.0 .. 1.0) < opts[:rate]
        t = opts[:cut_point] || rand(0..ch1.dna.length-1)
        os1 = Chromosome.new(ch1.built_by.merge(dna: ch1.dna[0..t] + ch2.dna[t+1..-1]))
        os2 = Chromosome.new(ch2.built_by.merge(dna: ch2.dna[0..t] + ch1.dna[t+1..-1]))
      end
      [os1, os2]
    end
  end

  def self.random_rate
    Proc.new do |ch1, ch2, opts|
      ch1.dna.each_index do |i|
        if rand(0.0 .. 1.0) < opts[:rate]
          ch1.dna[i], ch2.dna[i] = ch2.dna[i], ch1.dna[i]
        end
      end
      [ch1, ch2]
    end
  end
end
