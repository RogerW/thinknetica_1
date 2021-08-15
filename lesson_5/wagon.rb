class Wagon
  attr_reader :type
  def initialize(type)
    self.type = type
  end

  private

  attr_writer :type
end
