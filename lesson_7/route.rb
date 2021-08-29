require_relative 'instance_counter'
require_relative 'base_app'

class Route < BaseApp
  attr_reader :stations

  include InstanceCounter

  def initialize(start_point, end_point)
    self.stations = [start_point, end_point]

    super
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def del_station(station)
    return if @stations.first == station || station == @stations.last

    @stations.delete(station)
  end

  def to_s
    stations.map(&:name).join('->')
  end

  private

  attr_writer :stations

  protected

  def validate!
    raise(ArgumentError, "Начальная и конечная станции совпадают") if  stations.first == stations.last
  end
end
