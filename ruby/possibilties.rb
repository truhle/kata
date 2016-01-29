# Returns a hash with a lexically sorted array of all possible unique
# combinations of translations for each word, which are passed in as a hash of
# words and their translations.

def possibilities(words = {})
  words.reduce(Hash.new([])) do |combos, (k,v)|
    1.upto(v.length) do |i|
      combos[k] += v.combination(i).to_a.map {|combo| combo.sort }
    end
    combos[k].sort!
    combos
  end
end

p possibilities
# => {}

p possibilities({:life=>["vida", "vie", "Leben"], :death=>["muerte", "mort", "Tode"]})
# =>    {:life=>[["Leben"],
#              ["Leben", "vida"],
#                ["Leben", "vida", "vie"],
#                ["Leben", "vie"],
#                ["vida"],
#                ["vida", "vie"],
#                ["vie"]],
#       :death=>[["Tode"],
#                ["Tode", "mort"],
#                ["Tode", "mort", "muerte"],
#                ["Tode", "muerte"],
#                ["mort"],
#                ["mort", "muerte"],
#                ["muerte"]]
#       }
