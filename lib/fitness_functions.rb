module FitnessFunctions

  def self.dist_to_ones
    Proc.new do |dna|
      dna.length - dna.reduce(&:+)
    end
  end

end
