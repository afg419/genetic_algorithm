module FitnessFunctions
  def self.dist_to_ones
    Proc.new do |dna|
      dna.length - dna.reduce(&:+)
    end
  end

  def self.euc_dist_to_origin
    Proc.new do |dna|
      dna.reduce(0) do |acc, bp|
        acc + bp**2
      end**(0.5)
    end
  end
end
