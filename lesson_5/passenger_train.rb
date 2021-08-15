require_relative 'train'

class PassengerTrain < Train
  @@instances = 0

  def initialize(number)
    super(number, :passenger)
  end
end
