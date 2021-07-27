class Train
  attr_accessor :speed
  attr_reader :number
  attr_reader :type
  attr_reader :wagons

  def initialize(number, type)
    self.number = number
    self.type = type
  end

  def stop
    self.speed = 0
  end

  def attach_wagon(wagon)
    raise 'Поезд движется' if speed.positive
    raise 'Неверный тип вагона' if wagon.type != type

    @wagons << wagon
  end

  def detach_wagon(wagon)
    raise 'Поезд движется' if speed.positive?

    @wagons.delete wagon
  end

  def route=(route)
    @route = route

    @current_station_index = 0
  end

  def forward
    return if next_station

    @route[@current_station_index].train_send(self)
    @route[@current_station_index + 1].traint_add(self)
    @current_station_index += 1
  end

  def back
    return if back_station

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

  private

  # к данным методам доступ извне не нужен
  attr_writer :number
  attr_writer :type
end
