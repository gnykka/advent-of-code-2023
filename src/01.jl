# Puzzle 1, part a: 55447
# Puzzle 1, part b: 54706

data = readlines("./data/01.txt")

pattern_1 = "\\d"
pattern_2 = "one|two|three|four|five|six|seven|eight|nine"

word_to_digit = Dict("one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5,
                     "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9)

convert_to_number = v -> isdigit(v[1]) ? parse(Int, v) : word_to_digit[v]

function calculate(p_1, p_2)
  sum = 0

  pattern =  p_1 * (isempty(p_2) ? "" : ("|" * p_2))
  reversed_pattern  = p_1 * (isempty(p_2) ? "" : ("|" * reverse(p_2)))

  for str in data
    reversed_str = reverse(str)

    first_match = str[findfirst(Regex(pattern), str)]
    last_match = reversed_str[findfirst(Regex(reversed_pattern), reversed_str)]

    first_digit = convert_to_number(first_match)
    last_digit = convert_to_number(reverse(last_match))

    sum += first_digit * 10 + last_digit
  end

  return sum
end

result_a = calculate(pattern_1, "")
result_b = calculate(pattern_1, pattern_2)

println("Puzzle 1, part a: $result_a")
println("Puzzle 1, part b: $result_b")
