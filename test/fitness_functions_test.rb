require_relative '../lib/fitness_functions'
require_relative '../lib/chromosome'
require 'minitest/autorun'

class FitnessTest < Minitest::Test
  def test_exists
    assert Fitness
  end

  def test_computes_taxi_distance
    assert_equal 4, Fitness.taxi_dist([0,0,0,0])[[1,1,1,1]]
    assert_equal 9, Fitness.taxi_dist([1,3,2,1])[[0,-2,4,2]]
  end

  def test_computes_euc_distance
    assert_equal 2**(0.5), Fitness.euc_dist([0,0])[[1,1]]
    assert_equal 5, Fitness.euc_dist([3,3])[[0,-1]]
  end
end
