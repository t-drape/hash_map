# frozen_string_literal: true

require_relative('lib/hash_set/hash_set')

ec = HashSet.new

ec.set('apple')
ec.set('banana')
ec.set('carrot')
ec.set('dog')
ec.set('elephant')
ec.set('frog')
ec.set('grape')
ec.set('hat')
ec.set('ice cream')
ec.set('jacket')
ec.set('kite')
ec.set('lion')

p ec.keys
