# Returns given text justified to a given width.

def justify(text, width)
  txt_ary = text.scan(/\S+/)

  lines = txt_ary.reduce([[]]) do |ary, w|
    spaces = ary[-1].size
    new_length = (ary[-1] + [w]).reduce(spaces) { |sum, word| sum + word.length }
    new_length > width ? ary + [[w]] : ary.slice(0..-2) + [ary[-1] + [w]]
  end

  lines.map.with_index do |line, i|
    if i == lines.length - 1
      line.join(" ")
    else
      spaces = line.length - 1
      extra_spaces = width - line.reduce(spaces) { |sum, word| sum + word.length }
      es_per_word = extra_spaces / spaces rescue extra_spaces
      remainder_spaces = extra_spaces % spaces rescue 0
      justified_line = line.map.with_index do |w, i|
        if i == spaces
          w + "\n"
        else
          new_spaces = i < remainder_spaces ? es_per_word + 1 : es_per_word
          w + (" " * new_spaces)
        end
      end
      justified_line.join(" ")
    end
  end.join
end

text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

puts justify(text, 30)
# =>
# Lorem  ipsum  dolor  sit amet,
# consectetur  adipisicing elit,
# sed    do    eiusmod    tempor
# incididunt ut labore et dolore
# magna aliqua. Ut enim ad minim
# veniam,      quis      nostrud
# exercitation  ullamco  laboris
# nisi  ut aliquip ex ea commodo
# consequat.   Duis  aute  irure
# dolor   in   reprehenderit  in
# voluptate  velit  esse  cillum
# dolore    eu    fugiat   nulla
# pariatur.    Excepteur    sint
# occaecat     cupidatat     non
# proident,  sunt  in  culpa qui
# officia  deserunt  mollit anim
# id est laborum.

# A much more elegant and concise way of expressing a similar approach

def elegant_justify(text, width)
  text.split.reduce([[]]) do |lines, word|
    line = lines.last
    if (spaces = width - line.join(' ').length) > word.length
      line << word
    else
      spaces.times do |i|
        index = i % (line.count - 1) rescue 0
        line[index] += ' '
      end
      lines << [word]
    end
    lines
  end.map { |line| line.join(' ') }.join("\n")
end
