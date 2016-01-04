# Does successive runoffs, eliminating the candidates that received
# the fewest first place votes.  The voters parameter is an array of
# ballots with candidate names ordered from first choice to last choice.
# Returns the winner.

def runoff(voters)

  def find_winner(voters, tallies=nil)
    if tallies
      min = tallies.values.min
      tallies.keep_if { |candidate, v| v == min }
      voters.each { |voter| voter.reject! {|vote| tallies.include? vote }}
      return nil if voters.length == 0
    end
    new_tallies = Hash.new(0)
    voters[0].each {|candidate| new_tallies[candidate] = 0 }
    voters.each_with_object(new_tallies) { |voter, nt| nt[voter[0]] += 1 }
    total_votes = new_tallies.values.reduce(:+);
    new_tallies.each { |candidate, v|
      return candidate if v / total_votes.to_f > 0.5
    }
    return find_winner(voters, new_tallies)
  end

  find_winner(voters)

end

voters = [[:dem, :ind, :rep],
          [:rep, :ind, :dem],
          [:ind, :dem, :rep],
          [:ind, :rep, :dem]]

p runoff(voters)
# => :ind

voters2 = [ [ 'a', 'c', 'b', 'd', 'e' ],
[ 'd', 'c', 'a', 'b', 'e' ],
[ 'e', 'b', 'd', 'a', 'c' ],
[ 'e', 'a', 'b', 'c', 'd' ],
[ 'b', 'c', 'e', 'a', 'd' ] ]

p runoff(voters2)
# => "e"

voters3 = [[:d, :a, :c, :b, :e], [:b, :d, :e, :c, :a], [:b, :c, :d, :e, :a], [:c, :d, :e, :a, :b], [:c, :e, :b, :a, :d]]

p runoff(voters3)
# => :c

# A more concise approach.  Takes advantage of the fact that calling
# #first on an empty array returns nil.

def runoff(voters)
  results = voters.map(&:first).reduce({}) { |t,v| t[v] = (t[v] || 0) + 1; t }
  most_votes, least_votes = results.values.max, results.values.min
  winners = results.select { |k,v| v == most_votes }.keys
  losers = results.select { |k,v| v == least_votes }.keys
  reduced_ballots = voters.map do |voter|
    voter.delete_if { |can| losers.include?(can) }
  end
  winners.length == 1 ? winners.first : runoff(reduced_ballots)
end
