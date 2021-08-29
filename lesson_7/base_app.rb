class BaseApp
  def initialize(*any)
    validate!
  end

  def valide?
    validate!
    true
  rescue ArgumentError
    false
  end

  protected

  def validate!
    raise(NotImplementedError, "Не определена функция validate! в классе #{__class__}")
  end
end