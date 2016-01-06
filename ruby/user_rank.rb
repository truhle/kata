# A User class that implements a ranking system based on
# completing ranked activities.

class User

  attr_accessor :progress, :rank

  def initialize
    @progress = 0
    @rank = -8
  end

  def inc_progress(a_rank)
    if a_rank < -8 || a_rank > 8 || a_rank == 0
      raise ArgumentError
    elsif rank == 8
      return nil
    end

    dif = normalize(a_rank) - normalize(rank)
    new_prog = 0

    if dif == -1
      new_prog = 1
    elsif dif == 0
      new_prog = 3
    elsif dif > 0
      new_prog = 10 * (dif ** 2)
    end

    self.progress += new_prog
    rank_up
  end

private

  def normalize(n)
    n += 1 if n < 0
    n + 8
  end

  def rank_up
    while progress >= 100 && rank < 8
      self.progress -= 100
      self.rank = revert(normalize(rank) + 1)
      self.progress = 0 if rank == 8
    end
  end

  def revert(n)
    n -= 1 if n - 8 < 1
    n - 8
  end
end

user = User.new
p user.rank #=> -8
p user.progress #=> 0
user.inc_progress(-7)
p user.progress #=> 10
user.inc_progress(-4)
p user.progress #=> 70
p user.rank #=> -7

#  A more elegant solution using a indexes of a RANKS array to
# avoid the need for normalization and reversion.

class ElegantUser
  RANKS = [-8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8]

  def initialize
    @points = 0
  end

  def rank
    RANKS[@points / 100] || 8
  end

  def progress
    rank == 8 ? 0 : @points % 100
  end

  def inc_progress(completed_rank)
    raise "Invalid rank" unless index = RANKS.index(completed_rank)

    @points += case delta = index - @points / 100
    when -1    then 1
    when 0     then 3
    when 1..16 then 10 * delta * delta
    else            0
    end
  end
end
