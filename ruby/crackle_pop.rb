def crackle_pop(n)
  (1..n).each do |n|
    entry = ""
    entry += "Crackle" if n % 3 == 0
    entry += "Pop" if n % 5 == 0
    puts entry == "" ? n : entry
  end
end

crackle_pop(100)
