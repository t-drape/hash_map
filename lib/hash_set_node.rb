# frozen_string_literal: true

# A Ruby class model of a node for the implementation of a HashSet
class Node
  attr_accessor :key, :value, :next_node

  def initialize(key, value)
    @key = key
    @value = value
    @next_node = nil
  end
end
