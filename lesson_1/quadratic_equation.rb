#!/usr/bin/env ruby

coef = []

%i[A B C].each do |c|
  print "Введите коэффициент #{c}: "
  coef.push gets.to_i
end

a,b,c = coef

d = b**2 - 4*a*c

case
when d > 0
  d2 = Math.sqrt(d)
  puts "Дискриминант: #{d}"
  puts "Корень х1: #{(-b+d2)/(2.0*a)}"
  puts "Корень х2: #{(-b-d2)/(2.0*a)}"
when d == 0
  puts "Дискриминант: #{d}"
  puts "Корень х1=x2: #{-b/(2.0*a)}"
else
  puts "Корней нет"
end
