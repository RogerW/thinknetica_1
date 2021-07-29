#!/usr/bin/env ruby

require_relative 'common_loader'

@header = Header.new
@flash = false
@trainz = []
@stations = []
@routes = []

main_menu = %i[create_station create_train manage_route assign_route attach_wagon detach_wagon move_train list_station]

def create_train
  print 'Введите номер поезда, или оставте поле пустым для отмены: '
  number = gets.chomp

  return if number.length.zero?

  puts @header.train_type_menu
  puts 'Выберите тип поезда'

  types = { 1 => :passenger, 2 => :cargo }
  loop do
    type = types[gets.to_i]
    if type
      @trainz.push type == :passenger ? PassengerTrain.new(number) : CargoTrain.new(number)
      @flash = "Поезд номер #{number} успешно добавлен"
      break
    end
    puts 'Неверный тип, повторите попытку'
  end
end

def create_station
  print 'Введите название станции или оставте поле пустым для отмены: '
  name = gets.chomp

  return if name.length.zero?

  @stations << Station.new(name)
  @flash = "Станция #{name} успешно создана"
end

def print_stations
  puts "\n#{' ' * 6}Список станций: \n"
  @stations.each_with_index do |station, pos|
    puts "#{' ' * 6}#{pos}. #{station.name}"
  end
end

def print_route(route)
  route.stations.map(&:name).join('->')
end

def print_routes
  puts "\n#{' ' * 6}Список маршрутов: \n"
  @routes.each_with_index do |route, pos|
    puts "#{' ' * 6}#{pos}. #{print_route(route)}"
  end
end

def print_trains
  pp @trainz
  puts "\n#{' ' * 6}Список поездов: \n"
  @trainz.each_with_index do |train, pos|
    puts "#{' ' * 6}#{pos}. #{train.number}"
  end
end

def create_route
  start = []
  stop = []

  print_stations

  loop do
    print 'Введите номер начальной станции: '
    start_index = gets.to_i
    if @stations.size > start_index
      start = @stations[start_index]
      break
    else
      puts 'Неверный номер станции, попробуйте еще раз'
    end
  end

  loop do
    print 'Введите номер конечной станции: '
    end_index = gets.to_i
    if @stations.size > end_index && @stations[end_index] != start
      stop = @stations[end_index]
      break
    else
      puts 'Неверный номер станции, попробуйте еще раз'
    end
  end

  @routes << Route.new(start, stop)
  @flash = "Маршрут #{print_route @routes.last} успешно создан"
end

def edit_route
  if @stations.size <= 2
    puts 'Число известных станций две или менее. Добавьте еще станций'
    return
  end

  print_stations
  print_routes

  puts "Введите команду в формате  <номер маршрута> <удалить '-'/додавить '+'> <номер станции>, 9 для выхода"
  loop do
    print '# '
    route, action, station = gets.chomp.split(/\s/)

    route = route.to_i
    station = station.to_i

    return if route == 9 && !action

    error = false
    error = true unless (0...@routes.size).include? route
    error = true unless ['+', '-'].include? action
    error = true unless (0...@stations.size).include? station

    if error
      puts 'Неверная команда'
    else
      route = @routes[route]
      station = @stations[station]

      case action
      when '+'
        if route.stations.include? station
          puts 'Станция уже есть в машруте'
        else
          route.add_station(station)
          puts 'Станция добавлена'
        end
      else
        route.del_station(station)
      end
    end
  end
end

def assign_route
  print_routes
  print_trains

  sleep 10
end

def manage_route
  if @stations.size < 2
    @flash = 'Число известных станций меньше двух. Добавте еще станций'
    return
  end

  print_routes
  puts @header.route_menu

  loop do
    print 'Выберите пункт: '
    current_command = gets.to_i

    case current_command
    when 1
      create_route
      break
    when 2
      edit_route
      break
    when 9
      return
    else
      puts 'неверная комманда'
    end
  end
end

loop do
  puts `clear`
  puts @header.main_logo
  puts "#{' ' * 20}Добро пожаловать в программный комплекс управления железнодорожной сетью"
  puts @header.main_menu

  puts @flash if @flash
  @flash = false

  print 'Выберите пункт: '
  current_command = gets.to_i

  break if current_command == 9

  case main_menu[current_command - 1]
  when :create_station
    create_station
  when :create_train
    create_train
  when :manage_route
    manage_route
  when :assign_route
    assign_route
  else
    @flash = 'неизвестная комманда'
  end
end
