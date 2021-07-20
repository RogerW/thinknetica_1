#!/usr/bin/env ruby

print "Введите ваше имя: "
user_name = gets.chomp

print "Введите ваш рост: "
user_height = gets.to_i

print "Введите ваш вес: "
user_weight = gets.to_i

ideal_weight = (user_height - 110) * 1.15

puts "#{user_name}, Ваш идеальный вес #{ideal_weight} кг."
puts "Ваш вес уже оптимальный" if ideal_weight < 0
