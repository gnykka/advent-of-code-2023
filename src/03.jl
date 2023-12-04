# Puzzle 3, part a: 527446
# Puzzle 3, part b: 73201705

data = readlines("./data/03.txt")

function calculate_sum()
  is_symbol(v) = !isdigit(v) && v != '.'
  has_symbol(str) = occursin(r"[^0-9.]", str)

  sum = 0

  for (index, str) in enumerate(data)
    number_matches = findall(r"\d+", str)

    prev_str = index > 1 ? data[index - 1] : repeat(".", length(str))
    next_str = index < length(data) ? data[index + 1] : repeat(".", length(str))

    for match in number_matches
      start_index = first(match)
      end_index = last(match)

      not_start_of_string = start_index > 1
      not_end_of_string = end_index < length(str)

      valid = not_start_of_string && is_symbol(str[start_index - 1]) ||
              not_end_of_string && is_symbol(str[end_index + 1]) ||
              has_symbol(prev_str[match]) || has_symbol(next_str[match]) ||
              not_start_of_string && is_symbol(prev_str[start_index - 1]) ||
              not_end_of_string && is_symbol(prev_str[end_index + 1]) ||
              not_start_of_string && is_symbol(next_str[start_index - 1]) ||
              not_end_of_string && is_symbol(next_str[end_index + 1])

      if valid
        sum += parse(Int, str[match])
      end
    end
  end

  return sum
end

function calculate_ratios()
  all_numbers = map(str -> findall(r"\d+", str), data)

  adjust_to_match(m, i) = first(m) - 1 <= i && i <= last(m) + 1
  get_neighbours(i, str, str_index) =
    all_numbers[str_index] |>
      filter(m -> adjust_to_match(m, i)) |>
      (matches -> map(m -> str[m], matches))

  sum = 0

  for (index, str) in enumerate(data)
    matches = findall(r"\*", str)

    prev_str = index > 1 ? data[index - 1] : repeat(".", length(str))
    next_str = index < length(data) ? data[index + 1] : repeat(".", length(str))

    for match in matches
      symbol_index = first(match)

      neighbours = []

      append!(neighbours, get_neighbours(symbol_index, str, index))
      append!(neighbours, get_neighbours(symbol_index, prev_str, index - 1))
      append!(neighbours, get_neighbours(symbol_index, next_str, index + 1))

      if length(neighbours) === 2
        sum += parse(Int, neighbours[1]) * parse(Int, neighbours[2])
      end
    end
  end

  return sum
end

result_a = calculate_sum()
result_b = calculate_ratios()

println("Puzzle 3, part a: $result_a")
println("Puzzle 3, part b: $result_b")
