# frozen_string_literal: true

require_relative('node')

# A Class Model for the Hash Map Data Structure
class HashMap
  def initialize
    @buckets = Array.new(16)
    @load_factor = 0.8
    @entries = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % 16
  end

  def hash_map_grow
    @entries += 1
    return unless @entries > @buckets.length * @load_factor

    new_arr = Array.new(@buckets.length)
    @buckets += new_arr
  end

  def set(key, value)
    hash_map_grow
    hash_val = hash(key)
    if @buckets[hash_val]
      node = @buckets[hash_val]
      until node.next_node.nil?
        if node.key == key
          node.value = value
          break
        end
        node = node.next_node
      end
      if node.key == key
        node.value = value
      else
        node.next_node = Node.new(key, value)
      end
    else
      @buckets[hash_val] = Node.new(key, value)
    end
  end
end

hash_map = HashMap.new

hash_map.set('CARLOS', 'hoolla')
p hash_map
