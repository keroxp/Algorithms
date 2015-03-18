#! /usr/bin/env ruby

class BinaryTree
  attr_accessor :size

  def initialize
    @size = 0
  end

  def insert (v)
    unless @root
      @root = Node.new v, nil
    else
      _insert v, @root
    end
    @size += 1
  end

  def delete (v)
    if _delete v, @root
      @size -= 1
    end
  end

  def get (v)
    _get v, @root, 1
  end

  ## 二分探索木の条件
  ## 子を持つノードの場合、
  ## 左は必ず自分以下
  ## 右は必ず自分以上
  def check
    q = [@root]
    while !q.empty?
      n = q.shift
      if (n.left_child and n.val < n.left_child.val) or (n.right_child and n.right_child.val < n.val)
        p "binary tree is breaked"
        return false
      end
      q.push n.left_child if n.left_child
      q.push n.right_child if n.right_child
    end
    p "binary tree is correct."
    return true
  end

  private

  class Node
    attr_accessor :val, :parent, :left_child, :right_child
    def initialize (v, parent)
      @val = v
      @parent = parent
    end
    def is_leaf?
      return (@left_child == nil and @right_child == nil)
    end
    def depth
      return @parent ? @parent.depth+1 : 1
    end
    def change_child (node, new_node)
      if @left_child == node
        @left_child = new_node
      elsif @right_child == node
        @right_child = new_node
      end
    end
  end

  def _insert (v, node)
    if v <= node.val
      if node.left_child
        _insert v, node.left_child
      else
        n = Node.new v, node
        node.left_child = n
      end
    else
      if node.right_child
        _insert v, node.right_child
      else
        n = Node.new v, node
        node.right_child = n
      end
    end
  end

  def _delete (v, node)
    if v == node.val
      if node.is_leaf?
        node.parent.change_child node, nil
        node.parent = nil
      else
        if node.left_child and node.right_child
          # 削除対象が左右の子を持つノードの場合、その右の子を起点に
          # 最左探索を行い、そのノードと削除対象を入れ替える
          m = node.right_child
          while m.left_child
            m = m.left_child
          end
          if m.is_leaf?
            # 見つかったノードが葉の場合はそれと削除対象を入れ替える
            m.parent.left_child = nil
          else
            # 見つかったノードに右の子がいる場合は、右の個の親を入れ替える
            m.parent.left_child = m.right_child
            m.right_child.parent = m.parent
          end
          # 削除対象とその次に大きいノードを入れ替える
          node.parent.change_child node, m if node.parent
          m.parent = node.parent
          m.left_child = node.left_child
          m.right_child = node.right_child
        elsif node.left_child
          if node.parent
            node.parent.change_child node, node.left_child
          end
          node.left_child.parent = node.parent
        elsif node.right_child
          if node.parent
            node.parent.change_child node, node.right_child
          end
          node.right_child.parent = node.parent
        end
      end
      return node
    else
      if v <= node.val
        if node.left_child
          _delete v, node.left_child
        else
          p "#{v} does not exit in the tree."
          return nil
        end
      else
        if node.right_child
          _delete v, node.right_child
        else
          p "#{v} does not exit in the tree."
          return nil
        end
      end
    end
  end

  def _get (v, node, cnt)
    if v < node.val
      if node.left_child
        _get v, node.left_child, cnt+1
      else
        p "#{v} does not exist in the tree"
        return
      end
    elsif node.val < v
      if node.right_child
        _get v, node.right_child, cnt+1
      else
        p "#{v} does not exist in the tree"
      end
    elsif node.val == v
      if node.left_child and node.left_child.val == v
        _get v, node.left_child, cnt+1
      else
        p "#{v} was found."
        p "total traversal count is #{cnt}, of size: #{@size}"
        return node
      end
    end
  end
end

def main
  bt = BinaryTree.new
  n = 10000
  arr = (0..n).map { |e| rand n }
  arr.push 1
  # p arr
  for a in arr
    bt.insert a
  end
  bt.check
  bt.insert 19
  bt.check
  bt.delete arr[rand 20]
  bt.check
  p (bt.get 1).val
end

main