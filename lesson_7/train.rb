# frozen_string_literal: true

require_relative 'vendor'
require_relative 'instance_counter'
require_relative 'base_app'

class Train < BaseApp
  attr_accessor :speed
  attr_reader :route
  attr_reader :number
  attr_reader :type
  attr_reader :wagons

  include Vendor
  include InstanceCounter

  @@all_trains = []

  def initialize(number, type)
    self.number = number
    self.type = type
    self.wagons = []
    self.speed = 0

    super

    @@all_trains << self

    register_instance
  end

  def self.find(number)
    @@all_trains.find { |train| train.number == number }
  end

  def stop
    self.speed = 0
  end

  def attach_wagon(wagon)
    raise 'Поезд движется' if speed.positive?
    raise 'Неверный тип вагона' if wagon.type != type

    wagons << wagon
  end

  def detach_wagon(wagon)
    raise 'Поезд движется' if speed.positive?

    wagons.delete wagon
  end

  def route=(route)
    @route = route

    @current_station_index = 0
    route.stations.first.traint_add(self)
  end

  def forward
    return if next_station

    @route.stations[@current_station_index].train_send(self)
    @route.stations[@current_station_index + 1].traint_add(self)
    @current_station_index += 1
  end

  def back
    return if back_station

    @route.stations[@current_station_index].train_send(self)
    @route.stations[@current_station_index - 1].traint_add(self)
    @current_station_index -= 1
  end

  def back_station
    @route.stations[@current_station_index - 1] if @current_station_index.positive?
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1] if @route.stations.length < @current_station_index
  end

  private

  # к данным методам доступ извне не нужен
  attr_writer :number
  attr_writer :type
  attr_writer :wagons

  protected 

  def validate!
    raise(ArgumentError, "Неверный номер поезда. Допустимай формат: XXX(-)XX") if number !~ /\A[a-zA-Z\d]{3}-?[a-zA-Z\d]{2}\z/
  end
end
