# frozen_string_literal: true

require_relative('node')

# A Class Model for the Hash Map Data Structure
class HashMap
  attr_reader :length

  def initialize
    @buckets = Array.new(16)
    @load_factor = 0.8
    @length = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % 16
  end

  def hash_map_grow
    return unless @length > (@buckets.length * @load_factor)

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
          return
        end
        node = node.next_node
      end
      if node.key == key
        node.value = value
        return
      end
      @length += 1
      node.next_node = Node.new(key, value)
    else
      @length += 1
      @buckets[hash_val] = Node.new(key, value)
    end
  end

  def get(key)
    hash_val = hash(key)
    node = @buckets[hash_val]
    until node.nil?
      return node.value if node.key == key

      node = node.next_node
    end
    nil
  end

  def has?(key)
    @buckets.each do |node|
      until node.nil?
        return true if node.key == key

        node = node.next_node
      end
    end
    false
  end

  def remove(key)
    return nil unless has?(key)

    @length -= 1
    node = @buckets[hash(key)]
    prev_node = node
    until node.key == key
      prev_node = node
      node = node.next_node
    end
    return_val = node.value
    prev_node.next_node = node.next_node
    return_val
  end
end

hash_map = HashMap.new

hash_map.set('CARLOS', 'hoolla')
hash_map.set('CARLOS', 'hola')
hash_map.set('ClaraS', 'holaaaaaa')
hash_map.set('RANDOMBLOKE', 'oyy')
# p hash_map.remove('ClaraS')
p hash_map
p hash_map.length
