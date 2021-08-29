require_relative 'instance_counter'
require_relative 'base_app'

class Station < BaseApp
  attr_accessor :name
  attr_reader :trains

  include InstanceCounter

  @@all_stations = []

  def initialize(name)
    self.name = name

    super

    @trains = []
    @@all_stations << self
  end

  def self.all
    @@all_stations
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type.to_sym }
  end

  def train_send(train)
    @trains.delete train
  end

  def traint_add(train)
    @trains << train
  end

  protected 

  def validate!
    raise(ArgumentError, "Минимальная длина 3 символа") if  name.length < 3
  end
end
