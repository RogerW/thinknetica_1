#!/usr/bin/env ruby

mday = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
}.freeze

puts "\n=== variant 1 ===\n"
# variant 1
mday.each do |k, v|
  puts k if v == 30
end

puts "\n=== variant 1 ===\n"
# variant 2
puts mday.select { |_k, v| v == 30 }.keys
