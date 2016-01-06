# Evaluates reverse polish notation expressions passed in as strings

def calc(expr)
  expr = expr.split
  res, a = nil, []
  expr.each do |c|
    if c.match /\d/
      a << c.to_f
    elsif res
      res = res.send c, a.pop
    else
      res = a.slice!(-2).send c, a.slice!(-1)
    end
  end
  a.length > 0 ? a.pop : res || 0
end

p calc("1 3 +") #=> 4.0
p calc("1 3 -") #=> -2.0
p calc("5 1 2 + 4 * + 3 -") #=> 14.0

# A more elegant approach

def elegant_calc(expr)
  expr.split.each_with_object([]) { |e, a|
    if e.match(/\d+/)
      a << e.to_f
    else
      y, x = a.pop, a.pop
      a << x.send(e, y)
    end
  }.last || 0
end
