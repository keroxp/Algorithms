#! /usr/bin/env ruby

# クイックソートの関数
def qsort (arr,left,right)
  return if right-left < 1
  i = left
  j = right
  piv = arr[right]
  while true
    while arr[i] < piv
      i += 1
    end
    while piv < arr[j]
      j -= 1
    end
    break if j <= i
    tmp = arr[i]
    arr[i] = arr[j]
    arr[j] = tmp
    i += 1
    j -= 1
  end
  qsort arr, left, i-1
  qsort arr, j+1, right
end

# ソート済みかどうかを確かめる
def sorted? (arr)
  for i in 1..arr.length-1
    return false if arr[i-1] > arr[i]
  end
  return true
end

def main
  arr = (0..10).map { |e| rand 100 }
  p arr
  qsort arr, 0, arr.length-1
  p arr
  p sorted? arr
end

main