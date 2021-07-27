#!/usr/bin/env ruby

require_relative 'common_loader'

puts `clear`
puts Header.main_logo
puts ' ' * 35 + 'Добро пожаловать в программный комплекс управления железнодорожной сетью'

current_command = ''

loop do
  puts '1,1,2,324./  2342343 3 1'
  i = gets.to_i

  break if i.zero?
end
