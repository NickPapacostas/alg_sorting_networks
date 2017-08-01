defmodule SortingNetworkTest do
  use ExUnit.Case

  doctest SortingNetwork
  import SortingNetwork

  setup do
    [
      comparators: [
        [{0,1}],
        [{1, 2}]
      ],
      invalid_comparators: [
        [{0,1}, {1, 2}],
        [{1, 2}, {2,4}]
      ]
    ]
  end

  test "swap if greater" do
    assert swap_if_greater([2,1,1], {0, 1}) == [1,2,1]
    assert swap_if_greater([1,2,1], {0, 1}) == [1,2,1]
  end

  test "compare swap" do 
    assert compare_swap([2,2,1,1], [[{0,2}], [{1, 3}]]) == [1,1,2,2]
    assert compare_swap([2,2,1,1], [[{0,2}], [{1, 3}]]) == [1,1,2,2]
  end

  test "validity", context do 
    assert is_valid?(context[:comparators]) == true
  end

  test "catches ambiguous stages", context do 
    assert is_valid?(context[:invalid_comparators]) == false
  end

  test "basic sorting network" do
    for z <- 0..10 do 
      input = for x <- 0..Enum.random(10..100), do: Enum.random(1..50)
      comparators = build_sorting_network(length(input))
      
      assert is_valid? comparators
      assert main(comparators, input) == Enum.sort(input)
    end
  end
end
