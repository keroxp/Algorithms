#!/usr/bin/env coffee

###
  Quick Sort in CoffeeScript
  by keroxp
###

ran = (max, len) ->
  i = 0;
  ret = []
  while i < len
    ret.push Math.floor(Math.random()*max)
    ++i
  return ret

med = (i,j,k)->
  # console.log "piv #{i}|#{j}|#{k} => "
  if i >= j and i >= k
    return Math.max(j,k)
  else if j >= i and j >= k
    return Math.max(i,k)
  else if k >= i and k >= j
    return Math.max(i,j)

qs = (arr, left, right) ->
  console.log arr.slice left,right+1
  # console.log arr
  return if right-left < 1
  i = left
  j = right
  # choose pivot
  k = Math.floor((i+j)/2)
  piv = med arr[left], arr[k], arr[right]
  console.log piv
  loop
    i++ while piv > arr[i]
    j-- while piv < arr[j]
    break if j <= i
    tmp = arr[i]
    arr[i] = arr[j]
    arr[j] = tmp
    i++
    j--
  # console.log "i:#{i} j:#{j}"
  qs arr, left, i-1
  qs arr, j+1, right

# a = [31,99,2,4,66,7,0,9,20,99,23]
a = ran 100, 10
console.log a
qs a, 0, a.length-1
console.log a