require 'minitest/autorun'
require_relative '../lib/neural_no_back_prop/neural_network'

class NetworkConstructorTest < Minitest::Test

  def test_exists
    assert NetworkConstructor
  end

  def test_creates_neuron_layers
    nn = NeuralNetwork.new(0,0,0,0,build: false)
    nl = nn.new_layer(4)

    assert_equal 4, nl.length

    nl.each do |x|
      assert_equal Neuron, x.class
    end

    nl.each_index do |i|
      refute_equal nl[i], nl[i+1]
    end
  end

  def test_creates_neurons
    nn = NeuralNetwork.new(4,3,2,4,build: false)
    nn.create_neurons

    assert_equal 5, nn.layers.length

    nn.layers.each do |layer|
      layer.all? {|x| x.class == Neuron}
    end

    assert_equal 4, nn.layers[0].length
    assert_equal 2, nn.layers[1].length
    assert_equal 2, nn.layers[2].length
    assert_equal 2, nn.layers[3].length
    assert_equal 4, nn.layers[4].length
  end

  def test_creates_weights_between_adjacent_neuron_arrays
    source_nl = Array.new(3,0).map{|x| Neuron.new}
    target_nl = Array.new(2,0).map{|x| Neuron.new}
    nn = NeuralNetwork.new(0,0,0,0, build: false)
    nn.add_weights_between(source_nl,target_nl)

    assert_equal 6, nn.weights.length

    source_nl.each do |neuron|
      assert_equal 2, neuron.weights_out.length
      assert_equal 0, neuron.weights_in.length
    end

    target_nl.each do |neuron|
      assert_equal 0, neuron.weights_out.length
      assert_equal 3, neuron.weights_in.length
    end
  end

  def test_creates_weights
    nn = NeuralNetwork.new(4,3,2,4,build: false)
    nn.create_neurons
    nn.create_weights

    assert_equal 24, nn.weights.length

    nn.weights.each do |weight|
      assert nn.layers.flatten.include?(weight.source)
      assert nn.layers.flatten.include?(weight.target)
    end

    nn.weights.each do |weight|
      source = weight.source
      target = weight.target

      assert source.weights_out.include?(weight)
      assert target.weights_in.include?(weight)
    end

    neurons = nn.weights.map{|weight| [weight.source, weight.target]}

    assert_equal neurons.flatten.uniq.count, nn.layers.flatten.uniq.count

    #specifics

    nn.layers[0].each do |neuron|
      assert_equal 2, neuron.weights_out.length
      assert_equal 0, neuron.weights_in.length
    end

    nn.layers[1].each do |neuron|
      assert_equal 2, neuron.weights_out.length
      assert_equal 4, neuron.weights_in.length
    end

    nn.layers[2].each do |neuron|
      assert_equal 2, neuron.weights_out.length
      assert_equal 2, neuron.weights_in.length
    end

    nn.layers[3].each do |neuron|
      assert_equal 4, neuron.weights_out.length
      assert_equal 2, neuron.weights_in.length
    end

    nn.layers[4].each do |neuron|
      assert_equal 0, neuron.weights_out.length
      assert_equal 2, neuron.weights_in.length
    end
  end

  def test_creates_biases
    nn = NeuralNetwork.new(4,3,2,4, build: false)
    nn.create_neurons
    nn.create_weights
    nn.create_biases

    nn.layers.each_index do |i|
     assert_equal -1, nn.layers[i].first.value
     assert_equal nn.layers[i+1].length - 1, nn.layers[i].first.weights_out.length
     refute_equal nn.layers[i].first, nn.layers[i+1].first
     assert_equal 0, nn.layers[i].first.weights_in.length
     break if nn.layers[i+1] == nn.layers[-2]
    end
  end

  def test_creates_network
    nn = NeuralNetwork.new(3,1,3,4)

    assert_equal 3, nn.layers.length

    assert_equal [4,4,4], nn.layers.map(&:length)
    20.times do
      i = [0,1].sample
      j1 = [0,1,2,3].sample
      j2 = [1,2,3].sample

      exists_unique = nn.weights.select do |weight|
        (weight.source == nn.layers[i][j1] && weight.target == nn.layers[i+1][j2])
      end.length

      assert_equal exists_unique, 1
    end
  end
end
