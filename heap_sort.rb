#! /usr/bin/env ruby

require "./heap"

arr = (1..10).map {|i| rand 100 }
ret = []
h = Heap.from_array arr
while !h.tree.empty?
  ret << h.delete_min
end
p arr
p ret