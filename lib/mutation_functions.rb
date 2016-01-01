module Mutation

  def self.bit_flip
   Proc.new do |_, bp|
      if bp == 0
        1
      elsif bp == 1
        0
      end
    end
  end

  def self.add_rand
    Proc.new do |mutate_max, bp|
      bp + rand(-1.0..1.0) * mutate_max
    end
  end

end
