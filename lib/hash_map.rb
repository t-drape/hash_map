# frozen_string_literal: true

require_relative('node')

# A Class Model for the Hash Map Data Structure
class HashMap
  attr_reader :length, :buckets

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
    return unless @length > (@buckets.length * @load_factor)

    new_arr = entries
    @buckets = Array.new(@buckets.length * 2)
    @length = 0
    new_arr.each do |key, value|
      set(key, value)
    end
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

test.set('apple', 'green')
test.set('lion', 'yellow')
test.set('kite', 'orange')

test.set('moon', 'silver')

puts test.buckets.length
