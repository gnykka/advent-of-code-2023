# Puzzle 2, part a: 3059
# Puzzle 2, part b: 65371

data = readlines("./data/02.txt")

rules = Dict("red" => 12, "green" => 13, "blue" => 14)

function check_iteration(iteration)
  parts = split(iteration, r", ")

  for part in parts
    quantity, color = split(part)

    if parse(Int, quantity) > rules[color]
      return false
    end
  end

  return true
end

function check_games()
  sum = 0

  for (index, str) in enumerate(data)
    game = split(str, r"(: )|(; )")
    deleteat!(game, 1)

    win = foldl((acc, el) -> acc && check_iteration(el), game, init=true)

    if win
      sum += index
    end
  end

  return sum
end

function calculate_power()
  sum  = 0

  for (index, str) in enumerate(data)
    game = split(str, r"(: )|(; )|(, )")
    deleteat!(game, 1)

    values = Dict("red" => 0, "green" => 0, "blue" => 0)

    for parts in game
      quantity, color = split(parts)
      values[color] = max(values[color], parse(Int, quantity))
    end

    sum += values["red"] * values["green"] * values["blue"]
  end

  return sum
end

result_a = check_games()
result_b = calculate_power()

println("Puzzle 2, part a: $result_a")
println("Puzzle 2, part b: $result_b")
