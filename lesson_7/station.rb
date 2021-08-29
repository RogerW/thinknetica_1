require_relative 'instance_counter'

class Station
  attr_accessor :name
  attr_reader :trains

  include InstanceCounter

  @@all_stations = []

  def initialize(name)
    self.name = name
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
end
