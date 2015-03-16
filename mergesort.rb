#! /usr/bin/env ruby

## マージ関数
def merge (arr, s1, e1, s2, e2)
  ret = []
  left = (s1..e1).to_a
  right = (s2..e2).to_a
  ## 与えらた配列の範囲s1~e1, s2~e2が
  ## 昇順にソートされているとして,
  ## それらの部分配列の先頭からピックしながら,
  ## 範囲を線形走査し終えるまで昇順にソートする
  while left.length+right.length > 1
    # 両方の範囲に候補が残っている場合は先頭同士を比較して
    # 小さい方をマージ後に入れる
    if left.length > 0 and right.length > 0
      lv = arr[left[0]]
      rv = arr[right[0]]
      if lv < rv
        ret << arr[left.shift]
      else
        ret << arr[right.shift]
      end
    elsif left.length == 0
      # どちらかが空になっている場合は片方の範囲の先頭を追加する
      ret << arr[right.shift]
    elsif right.length == 0
      ret << arr[left.shift]
    end
  end
  if left.length == 0
    ret << arr[right.shift]
  else
    ret << arr[left.shift]
  end
  i = 0
  for j in s1..e1
    arr[j] = ret[i]
    i += 1
  end
  for j in s2..e2
    arr[j] = ret[i]
    i += 1
  end
end

def msort (arr, left, right)
  w = right-left
  if w > 1
    # 幅が2より大きい場合はそれを更に再帰的に分割してマージする
    center = (left+right)/2-1
    msort arr, left, center
    msort arr, center+1, right
    merge arr, left, center, center+1, right
  elsif w == 1
    # 範囲が幅2になった場合のみソートする
    unless arr[left] < arr[right]
      tmp = arr[left]
      arr[left] = arr[right]
      arr[right] = tmp
    end
  end
end

def sorted? (arr)
  for i in 1..arr.length-1
    return false if arr[i-1] > arr[i]
  end
  return true
end

def main
  arr = (0..100).map { |e| rand 100 }
  p arr
  msort arr, 0, arr.length-1
  p arr
  p "array is sotrted? -> #{sorted? arr}"
end

main