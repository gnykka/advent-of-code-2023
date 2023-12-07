# Puzzle 6, part a: 2374848
# Puzzle 6, part b: 39132886

data = readlines("./data/06.txt")

function calculate_a()
  parseString(str) =
    split(str, r" ") |>
      (v -> filter!(!isempty, v)) |>
      (v -> deleteat!(v, 1)) |>
      (v -> map(i -> parse(Int, i), v))

  times = parseString(data[1])
  distances = parseString(data[2])

  mult = 1

  for (index, time) in enumerate(times)
    counts = 0

    for t in 1:time-1
      distance = t * (time - t)
      if distance > distances[index]
        counts += 1
      end
    end

    mult *= counts
  end

  return mult
end

function calculate_b()
  parseString(str) =
    replace(str, " " => "") |>
      (v -> split(v, r":")) |>
      (v -> deleteat!(v, 1)) |>
      (v -> parse(Int, v[1]))

  time = parseString(data[1])
  record_distance = parseString(data[2])

  counts = 0

  for t in 1:time-1
    distance = t * (time - t)
    if distance > record_distance
      counts += 1
    end
  end

  return counts
end

result_a = calculate_a()
result_b = calculate_b()

println("Puzzle 6, part a: $result_a")
println("Puzzle 6, part b: $result_b")
