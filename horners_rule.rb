#! /usr/bin/env ruby

###
# ホーナーの方法を計算する
# p(x) = An*X**n + An-1*X**n-1 ... + A1X + A0
#

class Horner
  def horner (as,x)
    ret = 0
    step = 0
    max = as.length
    for i in 1..max
      n = max-i
      if n == 0
        ret = ret + as[n]
      else
        ret = (ret + as[n]) * x
      end
      step = step + 1
    end
    p "done: step #{step}, ret: #{ret}"
    return ret
  end
  def simple (as,x)
    ret = 0
    step = 0
    max = as.length-1
    for i in 0..max
      ret = ret + as[i] * x**i
      step = step + (i+1)
    end
    p "done: step #{step}, ret: #{ret}"
    return ret
  end
end

h = Horner.new
len = rand 10
as = (0..len).map { |i| rand 100 }
p "a's: #{as}"
print "simple: => "
h.simple as, 3
print "horner: => "
h.horner as, 3

