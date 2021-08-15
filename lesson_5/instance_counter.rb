module InstanceCounter
  module ClassMethods
    @@instances = 0

    def instances
      puts @@instances
      @@instances
    end
  end

  module InstanceMethods
    private

    def register_instance
      @@instances += 1
    end
  end

  def self.included(klass)
    puts klass
    klass.extend ClassMethods
    klass.include InstanceMethods
  end
end
