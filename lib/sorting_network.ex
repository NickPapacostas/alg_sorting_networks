import(AssignmentExamples)

defmodule SortingNetwork do
  def main(comparators, input) do
    if comparators |> is_valid? do
      compare_swap(input, comparators)
    else 
      IO.puts "invalid comparators"
    end
  end

  def build_sorting_network(input) when is_list(input), do: build_sorting_network(length(input))
  def build_sorting_network(1), do: []
  def build_sorting_network(2), do: [[{0,1}]]
  def build_sorting_network(l) when l > 2 do
    new_comparators = for i <- l..1, do: [{i, i - 1}] 
    build_sorting_network(l - 1) ++ new_comparators
  end

  def is_valid?(comparators), do: is_valid?(comparators, [true])
  def is_valid?(_comparators, [false | _results]), do: false
  def is_valid?([], [true | _results]), do: true
  def is_valid?([current_step | rest], [result | rs ]) do
    is_unique = current_step 
      |> flatten_tuples 
      |> unique?

    # TODO: need to check for index out of bounds
    is_valid?(rest, [ is_unique | [result | rs]])
  end

  def unique?(list) do 
    length(list) == length(Enum.uniq(list))
  end

  def flatten_tuples(list_of_tuples) do 
    list_of_tuples |> Enum.flat_map( fn({x, y}) -> [x, y] end )  
  end

  def compare_swap(input, []), do: input
  def compare_swap(input, [[]]), do: input
  def compare_swap(input, [[] | [next_step | remaining_steps]]) do
    compare_swap(input, [next_step | remaining_steps])
  end
  def compare_swap(input, [[comparator | cs] | remaining_steps]) do 
    input 
    |> swap_if_greater(comparator)
    |> compare_swap([cs | remaining_steps])
  end

  def swap_if_greater(input, {ix1, ix2}) do
    [first, second] = Enum.sort([ix1, ix2])

    if ( Enum.at(input, first) > Enum.at(input, second) ) do 
      input 
      |> List.replace_at(second, Enum.at(input, first))
      |> List.replace_at(first, Enum.at(input, second))
    else
      input
    end
  end

  def is_sorting_network?(comparators) do
    random_inputs(5, 100) |> Enum.all?(fn(x) -> main(comparators, x) == Enum.sort(x) end)
  end

  def test_assignment_examples do
    for e <- AssignmentExamples.all, do: is_sorting_network?(e)
  end
  
  defp random_inputs(len, num) do
    for _x <- 0..num do 
      for _y <- 0..len-1, do: Enum.random(0..40) 
    end
  end
end
