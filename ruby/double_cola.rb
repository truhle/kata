# Calculates the person who drank the nth cola, in a queue
# where each person turns into two identical people each time they
# drink a cola, who both go to the back of the line.

def whoIsNext(names, r)
  n = -1
  while (r > 0) do
    n += 1
    section_size = 5 * (2 ** n)
    r -= section_size
  end
  section_location = section_size + r
  index = (section_location / (2 ** n).to_f).ceil - 1
  names[index]
end


p whoIsNext(["Sheldon", "Leonard", "Penny", "Rajesh", "Howard"], 7230702951)

# "Leonard"
