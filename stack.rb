#! /usr/bin/env ruby

class Stack
  def initialize
    @val = []
    @len = 0
  end
  def pop
    if @len > 0
      ret = @val[@len-1]
      @val.delete_at @len-1
      @len -= 1
      return ret
    end
    p "empty stack"
  end
  def push (v)
    @val[@len] = v
    @len += 1
  end
  def size
    @len
  end
end

s = Stack.new
s.push 1
s.push 2
p s.pop
p s.pop
s.push 3
s.push 4
p s.pop
p s.pop
p s.pop