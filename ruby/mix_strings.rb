# Takes two strings and returns a single string, made up repetitions of any
# lowercase letter that appears more frequently than once in either string.
# The number of repetitions is based on the string with the most repetitions
# of that character.  Each set of repetitions is prefixed by the number of the
# string that it came from (e.g. "1:" or "2:") or by an equal sign if both
# strings have that number of the character.  They are ordered primarily by
# number of repetitions, secondarily lexically.  They are separated by a forward
# slash.


def mix(s1, s2)
  a1, a2 = freq_list(s1), freq_list(s2)
  reduced_ary = (a1.map do |el|
    @element
    if a2.find { |el2| el == el2 }
      a2.delete el
      "=:" + el
    elsif a2.find { |el2| @element = el2; el[el2] }
      a2.delete @element
      "1:" + el
    elsif a2.find { |el2| @element = el2; el2[el] }
      a2[a2.index(@element)] = "2:" + @element
      next
    else
      "1:" + el
    end
  end.compact + a2.map { |el| el[0] == "2" ? el : "2:" + el }).sort { |a,b| a <=> b }
  lengths = reduced_ary.map { |el| el.length }.uniq.sort { |a,b| b <=> a }
  lengths.map do |l|
    accum = ""
    reduced_ary.select { |el| el.length == l }.each do |el2|
      equals_i = accum.index("=")
      if equals_i && el2[0] != "="
        accum.insert(equals_i, el2 + "/")
      else
        accum += el2 + "/"
      end
    end
    accum
  end.join.slice(0..-2)
end

def freq_list(string)
  characters = string.chars.select { |c| c.match /[a-z]/ }.sort
  first_char = characters.shift
  characters.reduce([[first_char]]) do |a, c|
    prev = a.last.last
    if prev.include? c
      prev << c
    else
      a << [c]
    end
    a
  end.map {|c_ary| c_ary.join }
     .reject { |entry| entry.length < 2 }
     .sort { |a,b| b.length <=> a.length }
end

p mix("zzzzzzzzasdfhjwekrhsjdfhksjdafhakwqlejrh sjdfhjwerAASdfhjekjw!",
"sdhgjklwejrhjehrtuidafghuiwerur whf lk!sdahfASDFSDf zzzzzzzz")
#=> "1:jjjjjjjj/=:zzzzzzzz/1:hhhhhhh/1:ddddd/1:fffff/1:eeee/1:kkkk/1:ssss/1:wwww/2:rrrr/1:aaa/2:uuu/2:gg/2:ii/2:ll"

p mix("looping is fun but dangerous", "less dangerous than coding")
#=> "1:ooo/1:uuu/2:sss/=:nnn/1:ii/2:aa/2:dd/2:ee/=:gg"


# A far better solution, using maps to keep track of the character, the string(s)
# it is from and the number of repetitions

def far_better_mix(s1, s2)
  hist = ('a'..'z').map{ |c| [c, s1.count(c), s2.count(c)] }.select{ |v| v[1] > 1 || v[2] > 1 }
  hist2 = hist.map { |v| [v[1] > v[2] ? -v[1] : -v[2], v[1] > v[2] ? '1' : v[1] < v[2] ? '2' : '=', v[0]] }
  hist2.sort.map{ |v| v[1] + ':' + v[2] * -v[0] }.join('/')
end
