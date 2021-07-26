class Train
  attr_reader :speed
  attr_reader :wagons

  def initialize(number, type, wagons)
    @number = number
    @type = type.to_sym
    @wagons = wagons
  end

  def set_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def wagon_inc
    raise 'Поезд движется' if @speed > 0

    @speed += 1
  end

  def wagon_deg
    raise 'Поезд движется' if @speed > 0

    @speed -= 1
  end

  def route=(route)
    @route = route

    @current_station_index = 0
  end

  def forward
    return if @route.length <= @current_station_index

    @route[@current_station_index].train_send(self)
    @route[@current_station_index + 1].traint_add(self)
    @current_station_index += 1
  end

  def back
    return if @current_station_index.zero?

    @route[@current_station_index].train_send(self)
    @route[@current_station_index - 1].traint_add(self)
    @current_station_index -= 1
  end

  def back_station
    @route[@current_station_index - 1] if @current_station_index.positive?
  end

  def current_station
    @route[@current_station_index]
  end

  def next_station
    @route[@current_station_index + 1] if @route.length < @current_station_index
  end
end
