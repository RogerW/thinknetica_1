#!/usr/bin/env ruby

array = [0, 1]

loop do
  first, secont = array.last(2)

  break if first + secont > 100

  array << first + secont
end

puts array
