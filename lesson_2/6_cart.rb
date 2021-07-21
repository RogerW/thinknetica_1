#!/usr/bin/env ruby

cart = {}

loop do
  print 'Введите название товара: '
  name = gets.chomp
  break if name == 'стоп'

  print 'Введите цену единицы товара: '
  price = gets.to_f
  print 'Введите количество товара: '
  count = gets.to_f

  cart[name] = { price: price, count: count, total: price * count }
end

pp cart

puts "Итого: #{cart.values.map { |h| h[:total] }.reduce(0, :+)}"
