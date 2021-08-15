require_relative 'vendor'

class Wagon
  attr_reader :type

  include Vendor

  def initialize(type)
    self.type = type
  end

  private

  attr_writer :type
end
