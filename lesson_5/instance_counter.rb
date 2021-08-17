module InstanceCounter
  module ClassMethods
    attr_accessor :instance_count

    def instances
      puts @instance_count
      @instance_count
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instance_count ||= 1
      self.class.instance_count += 1
    end
  end

  def self.included(klass)
    puts klass
    klass.extend ClassMethods
    klass.include InstanceMethods
  end
end
