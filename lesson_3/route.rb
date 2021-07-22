class Route
  attr_reader :stations

  def initialize(start_point, end_point)
    @stations << start_point << end_point
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def del_station(station)
    return if @stations.first == station || station == @stations.last

    @stations.delete(station)
  end
end
