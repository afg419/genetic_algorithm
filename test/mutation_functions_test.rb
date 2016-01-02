require_relative '../lib/mutation_functions'
require 'minitest/autorun'

class MutationTest < Minitest::Test
  def test_exists
    assert Mutation
  end

  def test_flips_bit
    assert_equal 1, Mutation.bit_flip[0]
    assert_equal 0, Mutation.bit_flip[1]
  end

  def test_adds_rand
    a = Array.new(4,0).map { Mutation.add_rand[0, max: 5]}

    a.each_with_index do |i, num|
      assert -5 <= num && num <= 5
      refute num == a[i+1] || num == a[i-1]
    end
  end
end
