# SortingNetwork

This is an Elixir implementation of a generic comparator network framework. In other words, it allows you to create a network in the form of a list of comparators and apply it to a list of inputs. 

Comparators take the form of a list of lists of tuples, where each tuple represents the input lines to be compared, and tuples are organized into lists representing "stages". The comparators in each stage can be run in parrallel and therefore there can't be two comparisons with the same input in the same phase. Example networks can be found in the tests under `test/sorting_network_test.ex`


## Running Locally

Assuming Elixir is installed the tests can be run using mix `mix test`.

To play around interactively with the app it can be run in an `iex` session using 

`iex -S mix`</br>
`comparators = [[{0,1}], [{1, 2}]]`</br>
`SortingNetwork.main(comparators, [3, 2])`</br>


## ALG Assignment

In order to determine whether the networks in the assignment were sorting networks, I built them in the right format under the `lib/assignment_examples.ex` file and then ran them using the `SortingNetwork.test_assignment_examples` method. 
