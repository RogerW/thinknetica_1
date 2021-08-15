require_relative 'train'

class CargoTrain < Train
  @@instances = 0

  def initialize(number)
    super(number, :cargo)
  end
end
