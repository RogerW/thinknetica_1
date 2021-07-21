#!/usr/bin/env ruby

mdays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

print 'Введите число: '
day = gets.to_i
print 'Введите месяц: '
month = gets.to_i
print 'Введите год: '
year = gets.to_i

mdays[1] += 1 if (year % 4).zero? && !(year % 100).zero? || (year % 400).zero?

puts "Порядковый номер даты #{mdays.first(month - 1).reduce(0, :+) + day}"
