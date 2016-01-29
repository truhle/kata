# Returns an array of the top 3 more frequently used words in a given text
# Constraints were to avoid generating an array as big as the initial string
# and to avoid sorting the entire list of word frequencies.

def top_3_words(text)
  freqs = Hash.new(0)
  text.scan(/[\w']+/i) { |w| freqs[w.downcase] += 1 if w.match(/\w/) }
  freqs.reduce([]) do |ary, (k, v)|
    if ary.length < 3
      ary << [k, v]
      ary.sort{ |(k,v),(k2,v2)| v2 <=> v }
    else
      new_ary = []
      ary.each do |(k2, v2)|
        if v > v2
          new_ary << [k,v]
          new_ary << [k2, v2]
          break
        else
          new_ary << [k2, v2]
        end
      end
      new_ary.slice(0, 3)
    end
  end.map {|(k,v)| k }
end


p top_3_words("In a village of La Mancha, the name of which I have no desire to call to
mind, there lived not long since one of those gentlemen that keep a lance
in the lance-rack, an old buckler, a lean hack, and a greyhound for
coursing. An olla of rather more beef than mutton, a salad on most
nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra
on Sundays, made away with three-quarters of his income.")
# => ["a", "of", "on"]

p top_3_words("e e e e DDD ddd DdD: ddd ddd aa aA Aa, bb cc cC e e e")
# => ["e", "ddd", "aa"]

p top_3_words("  //wont won't won't")
# => ["won't", "wont"]

p top_3_words("a a a b c c d d d d e e e e e")
# => ["e", "d", "a"]
