#!/usr/bin/env ruby

sides = []

%i[A B C].each do |side|
  print "Введите длину стороны #{side} треугольника: "
  sides.push gets.to_i
end

sides.sort!

if sides.first == sides.last
  puts "Равносторонний"
elsif sides[0] == sides[1] || sides[2] == sides[1]
  puts "Равнобедренный"
elsif sides[2]**2 == sides[0]**2 + sides[1]**2
  puts "Прямоугольный"
else
  puts "Обычный"
end