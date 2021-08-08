# !/usr/bin/env ruby

require_relative 'common_loader'

# @abstract
class Menu
  attr_reader :context

  def initialize(context)
    self.header = Header.new
    self.context = context
  end

  # @abstract
  def execute
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  protected

  attr_writer :context
  attr_accessor :header

  private

  def print_stations
    puts "\n#{' ' * 6}Список станций: \n"
    context.stations.each_with_index do |station, pos|
      puts "#{' ' * 6}#{pos}. #{station.name}"
    end
  end

  def print_route(route)
    route.stations.map(&:name).join('->')
  end

  def print_routes
    puts "\n#{' ' * 6}Список маршрутов: \n"
    context.routes.each_with_index do |route, pos|
      puts "#{' ' * 6}#{pos}. #{print_route(route)}"
    end
  end

  def print_trains
    puts "\n#{' ' * 6}Список поездов: \n"
    context.trainz.each_with_index do |train, pos|
      puts "#{' ' * 6}#{pos}. #{train.number}"
    end
  end

  def print_trainz_wagons
    puts "\n#{' ' * 6}Список поездов с вагонами: \n"
    row_cnt = context.trainz.map(&:wagons).map(&:size).max

    puts '|' + context.trainz.map { |train| train.number.ljust(18) }.join('|') + '|'
    puts '-' * (context.trainz.size * 19 + 1)

    (0...row_cnt).each do |row|
      print '|'
      puts context.trainz.map { |train|
             if train.wagons[row].nil?
               ' ' * 18
             else
               "#{row}. #{train.wagons[row].type}".ljust(18)
             end
           }.join('|') + '|'
    end
  end

  def print_stations_trainz
    puts "\n#{' ' * 6}Список станций и поездов: \n"

    row_cnt = context.stations.map(&:trains).map(&:size).max

    puts '|' + context.stations.map { |station| station.name.ljust(18) }.join('|') + '|'
    puts '-' * (context.stations.size * 19 + 1)

    (0...row_cnt).each do |row|
      print '|'
      puts context.stations.map { |station|
             if station.trains[row].nil?
               ' ' * 18
             else
               "#{row}. #{station.trains[row].number}".ljust(18)
             end
           }.join('|') + '|'
    end
  end
end

class CreateTrainMenu < Menu
  def execute
    print 'Введите номер поезда, или оставте поле пустым для отмены: '
    number = gets.chomp

    return if number.length.zero?

    puts header.train_type_menu
    puts 'Выберите тип поезда'

    types = { 1 => :passenger, 2 => :cargo }
    loop do
      type = types[gets.to_i]
      if type
        context.trainz.push type == :passenger ? PassengerTrain.new(number) : CargoTrain.new(number)
        context.flash = "Поезд номер #{number} успешно добавлен"
        break
      end
      puts 'Неверный тип, повторите попытку'
    end
  end
end

class CreateStationMenu < Menu
  def execute
    print 'Введите название станции или оставте поле пустым для отмены: '
    name = gets.chomp

    return if name.length.zero?

    context.stations << Station.new(name)
    context.flash = "Станция #{name} успешно создана"
  end
end

class CreateRouteMenu < Menu
  def execute
    start = []
    stop = []

    print_stations

    loop do
      print 'Введите номер начальной станции: '
      start_index = gets.to_i
      if context.stations.size > start_index
        start = context.stations[start_index]
        break
      else
        puts 'Неверный номер станции, попробуйте еще раз'
      end
    end

    loop do
      print 'Введите номер конечной станции: '
      end_index = gets.to_i
      if context.stations.size > end_index && context.stations[end_index] != start
        stop = context.stations[end_index]
        break
      else
        puts 'Неверный номер станции, попробуйте еще раз'
      end
    end

    context.routes << Route.new(start, stop)
    context.flash = "Маршрут #{print_route context.routes.last} успешно создан"
  end
end

class EditRouteMenu < Menu
  def execute
    if context.stations.size <= 2
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
      error = true unless (0...context.routes.size).include? route
      error = true unless ['+', '-'].include? action
      error = true unless (0...context.stations.size).include? station

      if error
        puts 'Неверная команда'
      else
        route = context.routes[route]
        station = context.stations[station]

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
end

class ManageRouteMenu < Menu
  def execute
    if context.stations.size < 2
      context.flash = 'Число известных станций меньше двух. Добавте еще станций'
      return
    end

    print_routes
    puts header.route_menu

    loop do
      print 'Выберите пункт: '
      current_command = gets.to_i

      case current_command
      when 1
        CreateRouteMenu.new(context).execute
        break
      when 2
        EditRouteMenu.new(context).execute
        break
      when 9
        return
      else
        puts 'неверная комманда'
      end
    end
  end
end

class AssignRouteMenu < Menu
  def execute
    print_routes
    print_trains

    puts 'Введите команду в формате <номер маршрута> <номер поезда>, 9 для выхода'
    loop do
      print '# '
      route, train = gets.chomp.split(/\s/).map(&:to_i)

      return if route == 9

      error = false
      error = true unless (0...context.routes.size).include? route
      error = true unless (0...context.trainz.size).include? train

      if error
        puts 'Неверная команда'
      else
        route = context.routes[route]
        context.trainz[train].route = route
      end
    end
  end
end

class AttachWagonMenu < Menu
  def execute
    print_trains

    loop do
      print_trainz_wagons

      puts 'Введите номер поезда для добавления вагона, "Выход" для возвращения к предыдущему меню'
      print '# '
      train = gets.chomp

      return if train.upcase == 'ВЫХОД'

      train = train.to_i

      error = false
      error = true unless (0...context.trainz.size).include? train

      if error
        puts 'Неверная команда'
      else
        context.trainz[train].attach_wagon(Wagon.new(context.trainz[train].type))
      end
    end
  end
end

class DetachWagonMenu < Menu
  def execute
    print_trains

    loop do
      print_trainz_wagons

      puts 'Введите номер поезда и номер отсыковываемого вагона в формате <номер поезда> <номер вагона>, "Выход" для возвращения к предыдущему меню'
      print '# '
      train, wagon = gets.chomp.split(/\s/)

      return if train.upcase == 'ВЫХОД'

      train = train.to_i
      wagon = wagon.to_i

      error = false
      error = true unless (0...context.trainz.size).include? train
      error = true unless (0...context.trainz[train]&.wagons.size).include? wagon

      if error
        puts 'Неверная команда'
      else
        context.trainz[train].detach_wagon(context.trainz[train]&.wagons[wagon])
      end
    end
  end
end

class MoveTrainMenu < Menu
  def execute
    print_trains

    loop do
      print_stations_trainz

      puts 'Введите номер поезда и направление в формате <номер поезда> <вперед/назад>, "Выход" для возвращения к предыдущему меню'
      print '# '
      train, direction = gets.chomp.split(/\s/)

      return if train.upcase == 'ВЫХОД'

      train = train.to_i

      error = false
      error = true unless (0...context.trainz.size).include? train
      error = true unless %w[вперед назад].include? direction&.downcase

      if error
        puts 'Неверная команда'
      else
        case direction.downcase
        when 'вперед'
          context.trainz[train].forward
        else
          context.trainz[train].back
        end
      end
    end
  end
end

class PrintStationTrainMenu < Menu
  def execute
    print_stations_trainz

    print 'Ввод для выхода в предыдущее меню...'
    gets
  end
end

class MainMenu < Menu
  def execute
    main_menu = %i[create_station create_train manage_route assign_route attach_wagon detach_wagon move_train list_station]

    loop do
      puts `clear`
      puts header.main_logo
      puts "#{' ' * 20}Добро пожаловать в программный комплекс управления железнодорожной сетью"
      puts header.main_menu

      puts context.flash if context.flash
      context.flash = false

      print 'Выберите пункт: '
      current_command = gets.to_i

      break if current_command == 9

      case main_menu[current_command - 1]
      when :create_station
        CreateStationMenu.new(context).execute
      when :create_train
        CreateTrainMenu.new(context).execute
      when :manage_route
        ManageRouteMenu.new(context).execute
      when :assign_route
        AssignRouteMenu.new(context).execute
      when :attach_wagon
        AttachWagonMenu.new(context).execute
      when :detach_wagon
        DetachWagonMenu.new(context).execute
      when :move_train
        MoveTrainMenu.new(context).execute
      when :list_station
        PrintStationTrainMenu.new(context).execute
      else
        context.flash = 'неизвестная комманда'
      end
    end
  end
end

class Main
  attr_reader :trainz, :stations, :routes

  attr_accessor :flash

  def initialize
    self.trainz = []
    self.stations = []
    self.routes = []
  end

  def execute
    MainMenu.new(self).execute
  end

  private

  attr_writer :trainz, :stations, :routes
end

Main.new.execute
