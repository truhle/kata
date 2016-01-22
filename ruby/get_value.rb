# Returns the value of the final key in a list of keys, each of which are one
# level more deeply nested than the first.  e.g. {a: {b: 2}, c: 3}  :a, :b would
# return 2.  If no such path of keys exists, returns a default value given as
# the first argument.

class Hash
  def get_value( default, *args )
    return default if args.length == 0
    value = args.reduce(self) { |s,v| s.class == Hash ? s[v] : nil }
    value ? value : default
  end
end

hsh = {a: {b: 2}, b: 2}
p hsh.get_value(1)
#=> 1

hsh2 = {:files=>{:mode=>1911}, :name=>"config"}

p hsh2.get_value( 0x0, :files, :mode )
#=> 1911
