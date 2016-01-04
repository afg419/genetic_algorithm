# genetic_algorithm

### This is a flexible implementation of genetic algorithms.  Given functions representing fitness, crossover, mutation, and selection, the program will evolve an initial population of chromosomes until a threshold level of fitness is met in the population (or for a specified number of iterations).  

#### Functionality:
Initialize a new genetic algorithm:   
 - `ga = GeneticAlgorithm.new(options)`

Here options is a hash representing all the parameters necessary for creating an algorithm.  These include...
- `:total` -- The total number of chromosomes in the population.
- `:count` -- The number of 'base pairs' or length of a chromosome.
- `:range` -- A range representing the max and min value a chromosome value can take.  (Chromosomes are initialized with random values in this range.  Use float ranges for floating point values.)
- `:threshold` -- An integer or float representing a sufficiently large fitness value.
- `:selection` -- A proc representing the means of choosing parents for new generations.
- `:crossover` -- A proc representing the means of mixing two parents together to make two children.
- `:fitness` -- A proc which returns the fitness score of a chromosome.
- `:mutation` -- A proc representing the means of mutating a chromosome's values.

The four procs may require additional options.  In the few procs I have included in this repo, we need e.g:
- `:m_rate` -- probability of mutation
- `:c_rate` -- probability of crossover

Once options are chosen, we can evolve the population and examine the best performing chromosome with:
- `ga.evolve(n)` -- will quit when 'n' is reached or when the maximum fitness in the population exceeds the threshold value. 
- `ga.fittest_chromosome.dna`


To add customized selection, crossover, fitness, and mutation functions, simply open the relevant functions file, e.g. selection_functions.rb, and write the desired function as a proc.  These files include basic examples for each as is.  Feel free to make pull requests as functions are added.
