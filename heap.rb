#! /usr/bin/env ruby

class Heap
  attr_accessor :tree
  def self.from_array (arr)
    # 配列中の最小値を見つける
    min = arr[0]
    min_index = 0
    i = 1
    while i < arr.length
      if arr[i] < min
        min = arr[i]
        min_index = i
      end
      i += 1
    end
    p "min is #{min}"
    # ヒープを作成し、残りの要素をすべてinsertする
    ret = Heap.new min
    i = 0
    while i < arr.length
      if i != min_index
        ret.insert arr[i]
      end
      i += 1
    end
    return ret
  end
  def initialize (root)
    @tree = [root]
  end
  def insert (v)
    i = @tree.length
    @tree[i] = v
    apply_rule_from_leaf i
  end
  def delete_min
    ret = @tree[0]
    @tree[0] = @tree[@tree.length-1]
    @tree.delete_at @tree.length-1
    apply_rule_to_leaf 0
    return ret
  end
  def is_leaf? (i)
    return !exists?(left_child_index(i))
  end
  def left_child_index (i)
    return 2*i+1
  end
  def parent_index (i)
    return (i+1)/2-1
  end
  def exists? (i)
    return i < @tree.length
  end
  def swap (i,j)
    tmp = @tree[i]
    @tree[i] = @tree[j]
    @tree[j] = tmp
  end
  ## ヒープルールをある葉でないノードから下へ適用していく
  def apply_rule_to_leaf (i)
    unless exists? i
      p "object does not exits at index: #{i}"
      return
    end
    unless is_leaf? i
      li = left_child_index i
      index_to_compare = li
      if exists? li+1
        index_to_compare = @tree[li] < @tree[li+1] ? li : li+1
      end
      # 子のうち小さい方と自身を比較し、もし子の方が小さい場合は
      # それらを入れ替えて、次の階層で同様にルールを適用する
      if @tree[index_to_compare] < @tree[i]
        swap i, index_to_compare
        apply_rule_to_leaf index_to_compare
      end
    end
  end
  ## ヒープルールを葉から根へ上へと適用していく
  def apply_rule_from_leaf (i)
    ## tree[i]が親よりも大きくなるまで繰り返す
    pi = parent_index i
    if -1 < pi
      if @tree[i] < @tree[pi]
        swap i, pi
        apply_rule_from_leaf pi
      end
    end
  end
  # ヒープルールを守っているかチェックする
  def check
    i = 0
    while i < @tree.length
      unless is_leaf? i
        li = left_child_index i
        if @tree[li] < @tree[i] || (exists?(li+1) && @tree[li+1] < @tree[i])
          p "heap breaked!!"
          exit 1
        end
      end
      i += 1
    end
    p "heap is correct."
  end
end

random_arr = []
i = 0
while i < 9
  random_arr[i] = rand 100
  i += 1
end
random_arr.uniq!
p random_arr
heap = Heap.from_array random_arr
p heap.tree
heap.check
p heap.delete_min
p heap.tree
heap.check