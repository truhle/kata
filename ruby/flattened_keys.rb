# returns a flattened hash, whose keys are prefixed with their previous nesting
# path separated by underscores.  If any key in the path is a string, the key
# is a string.


class Hash
  def flattened_keys(hsh = {}, prefix = nil, str_bool = false)
    reduce(hsh) do |h, (k, v)|
      str_bool = str_bool ? str_bool : k.is_a?(String)
      if v.is_a?(Hash)
        new_prefix = prefix ? prefix.to_s + k.to_s : k.to_s
        new_prefix += "_"
        new_prefix = str_bool ? new_prefix : new_prefix.to_sym
        v.flattened_keys(h, new_prefix, str_bool)
      else
        k = prefix ? prefix.to_s + k.to_s : k.to_s
        k = str_bool ? k : k.to_sym
        h[k] = v
      end
      h
    end
  end
end


unflat = {
  id: 1,
  info: {
    name: 'example',
    more_info: {
      count: 1
    }
  }
}

p unflat.flattened_keys
#=> {id: 1, info_name: 'example', info_more_info_count: 1}

test2 = {:a=>1, :b=>{:c=>2, "d"=>3, :e=>{"f"=>nil}}}

p test2.flattened_keys

#=> {:a=>1, :b_c=>2, "b_d"=>3, "b_e_f"=>nil}

# A more elegant approach, leveraging the power of :flat_map and :merge and
# splatting arrays while leaving out the str_bool

class Hash
  def elegant_flattened_keys(keys = [])
    flat_map do |key, value|
      if value.is_a?(Hash)
        value.elegant_flattened_keys([*keys, key])
      else
        new_key = [*keys, key].join('_')
        new_key = new_key.to_sym if [*keys, key].all? { |k| k.is_a? Symbol }
        { new_key => value }
      end
    end.reduce(:merge)
  end
end
