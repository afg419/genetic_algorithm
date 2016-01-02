module Crossover
  def self.single_point
    Proc.new do |ch1, ch2, opts|
      if rand(0.0 .. 1.0) < opts[:c_rate]
        t = opts[:cut_point] || rand(1..ch1.dna.length-1) #ensures a cut is always made
        os1 = Chromosome.new(ch1.built_by.merge(dna: ch1.dna[0..t-1] + ch2.dna[t..-1]))
        os2 = Chromosome.new(ch2.built_by.merge(dna: ch2.dna[0..t-1] + ch1.dna[t..-1]))
      else
        os1, os2 = Chromosome.new(ch1.built_by), Chromosome.new(ch2.built_by)
      end
      [os1, os2]
    end
  end

  def self.random_rate
    Proc.new do |ch1, ch2, opts|
      dna1, dna2 = ch1.dna.map{|x| x}, ch2.dna.map{|x| x}
      ch1.dna.each_index do |i|
        if rand(0.0 .. 1.0) < opts[:c_rate]
          dna1[i], dna2[i] = dna2[i], dna1[i]
        end
      end
      os1 = Chromosome.new(ch1.built_by.merge(dna: dna1))
      os2 = Chromosome.new(ch2.built_by.merge(dna: dna2))
      [os1, os2]
    end
  end
end
