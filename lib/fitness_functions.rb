module Fitness
  def self.taxi_dist(array)
    Proc.new do |dna|
      dna.each_index.reduce(0) do |acc, i|
        acc + (array[i] - dna[i]).abs
      end
    end
  end

  def self.euc_dist(array)
    Proc.new do |dna|
      dna.each_index.reduce(0) do |acc, i|
        acc + (array[i]-dna[i])**2
      end**(0.5)
    end
  end
end
