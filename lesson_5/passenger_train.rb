require_relative 'train'
require_relative 'instance_counter'

class PassengerTrain < Train
  include InstanceCounter

  def initialize(number)
    super(number, :passenger)
  end
end
