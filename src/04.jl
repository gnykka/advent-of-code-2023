# Puzzle 4, part a: 19855
# Puzzle 4, part b: 10378710

data = readlines("./data/04.txt")

function calculate_count(str)
  _, winning, current = split(str, r"(: )|( \| )")
  return intersect(split(winning), split(current)) |> length
end

function calculate_sum_b()
  scores = map(calculate_count, data)
  counts = ones(Int, length(scores))

  for (index, score) in enumerate(scores)
    for child_index in (index + 1):(index + score)
      counts[child_index] += counts[index]
    end
  end

  return sum(counts)
end

function calculate_sum_a()
  sum = 0

  for str in data
    count = calculate_count(str)
    if count > 0
      sum += 2 ^ (count - 1)
    end
  end

  return sum
end

result_a = calculate_sum_a()
result_b = calculate_sum_b()

println("Puzzle 4, part a: $result_a")
println("Puzzle 4, part b: $result_b")
