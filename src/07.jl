# Puzzle 6, part a: 250602641
# Puzzle 6, part b:

data = readlines("./data/07.txt")

#=
data = [
  "32T3K 765",
  "T55J5 684",
  "KK677 28",
  "KTJJT 220",
  "QQQJA 483"
]
=#

letters = Dict(
  "A" => "n",
  "K" => "m",
  "Q" => "l",
  "J" => "k",
  "T" => "j",
  "9" => "i",
  "8" => "h",
  "7" => "g",
  "6" => "f",
  "5" => "e",
  "4" => "d",
  "3" => "c",
  "2" => "b"
)

function calculate_a()
  function parse_line(line)
    hand, bid = split(line)
    char_counts = Dict()

    for char in hand
      char_counts[char] = get(char_counts, char, 0) + 1
    end

    counts = char_counts |> values |> collect
    type = 1

    if (5 in counts)
      type = 7
    elseif (4 in counts)
      type = 6
    elseif (3 in counts && 2 in counts)
      type = 5
    elseif (3 in counts)
      type = 4
    elseif (count(x -> x == 2, counts) === 2)
      type = 3
    elseif (2 in counts)
      type = 2
    end

    labels = join([letters[string(char)] for char in hand])

    return Dict(
      "hand" => hand,
      "bid" => bid,
      "type" => type,
      "labels" => labels,
    )
  end

  return data |>
    (array -> map(parse_line, array)) |>
    (array -> sort(array, by = x -> [x["type"], x["labels"]])) |>
    (array -> sum((i * parse(Int, v["bid"])) for (i, v) in enumerate(array)))
end

result_a = calculate_a()

println("Puzzle 7, part a: $result_a")
