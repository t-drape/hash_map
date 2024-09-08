# frozen_string_literal: true

require_relative('node')

# A Class Model for the Hash Map Data Structure
class HashMap
  attr_reader :length

  def initialize
    @buckets = Array.new(16)
    @load_factor = 0.75
    @length = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % @buckets.length
  end

  def hash_map_grow
    @length += 1
    return unless @length > (@buckets.length * @load_factor)

    new_arr = entries
    @buckets = Array.new(@buckets.length * 2)
    @length = 0
    new_arr.each do |key, value|
      set(key, value)
    end
  end

  def get_node(key)
    hash_val = hash(key)
    node = @buckets[hash_val]
    until node.nil?
      return node if node.key == key

      node = node.next_node
    end
    nil
  end

  def append_node(hash_val, key, value)
    node = @buckets[hash_val]
    node = node.next_node until node.next_node.nil?
    node.next_node = Node.new(key, value)
  end

  def set(key, value)
    # 1. hash map grow
    # 2. hash_val
    # 3. increase length
    if has?(key)
      get_node(key).value = value
    else
      hash_map_grow
      hash_val = hash(key)
      @buckets[hash_val] ? append_node(hash_val, key, value) : @buckets[hash_val] = Node.new(key, value)
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

  def multi_remove(node, key)
    prev_node = node
    until node.key == key
      prev_node = node
      node = node.next_node
    end
    prev_node.next_node = node.next_node
    node.value
  end

  def remove(key)
    return nil unless has?(key)

    @length -= 1
    node = @buckets[hash(key)]
    if node.key == key
      @buckets[hash(key)] = nil
      return node.value
    end
    multi_remove(node, key)
  end

  def clear
    @buckets = Array.new(16)
    @length = 0
  end

  def keys
    return_array = []
    @buckets.each do |node|
      until node.nil?
        return_array << node.key
        node = node.next_node
      end
    end
    return_array
  end

  def values
    return_array = []
    @buckets.each do |node|
      until node.nil?
        return_array << node.value
        node = node.next_node
      end
    end
    return_array
  end

  def entries
    return_array = []
    @buckets.each do |node|
      until node.nil?
        return_array << [node.key, node.value]
        node = node.next_node
      end
    end
    return_array
  end
end

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

test.set('moon', 'silver')

# Change the hash map grow position, and also alter the length adjustment spot, and the hash_val spot
