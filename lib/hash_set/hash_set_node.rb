# frozen_string_literal: true

# A Ruby class model of a node for the implementation of a HashSet
class Node
  attr_accessor :key, :next_node

  def initialize(key)
    @key = key
    @next_node = nil
  end
end
