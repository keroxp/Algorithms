#! /usr/bin/env ruby

def qs (arr)
  stack = [[0,arr.length-1]]
  while !stack.empty?
    sec = stack.pop
    l = i = sec[0]
    r = j = sec[1]
    c = (l+r)/2
    piv = [arr[i], arr[c], arr[j]].sort()[1]
    if r-l > 0
      loop do
        while arr[i] < piv
          i = i+1
        end
        while arr[j] > piv
          j = j-1
        end
        if i >= j
          break
        end
        tmp = arr[i]
        arr[i] = arr[j]
        arr[j] = tmp
        i = i+1
        j = j-1
      end
      stack.push [l,i-1] if i-1 >= l
      stack.push [j+1,r] if r >= j+1
    end
    # p stack
  end
end

def main
  arr = (1..10).map {|i| rand 100}
  # arr = (1..10000000).map {|i| rand 10000000 }
  p arr
  qs arr
  p arr
end

main
