require "pathname"
Pathname.glob("./prompt/*").each { |p| require "p" }
module Prompt

  class << self

    def included(base)
      base.send :extend, ClassMethods
    end

    def for(type)
      return type if type_map.value?(type)
      type_map[type]
    end

    def default
      type_map.default
    end

    def default=(obj)
      type_map.default = obj
    end

    def type_map
      @@type_map ||= setup_type_map
    end

    def setup_type_map
      HashWithIndifferentAccess.new
    end

    def register_type(klass, string)
      type_map[string] = klass
    end

    def register_types(klass, *strings)
      strings.each {|s| register_type(klass, s) }
    end

    def types
      type_map.values.uniq
    end

    def accepted_types
      type_map.keys.uniq
    end
  end

  module ClassMethods
    def type_for(*objects)
      Prompt.register_types(self, *objects)
    end

    def associated_types
      Prompt.type_map.select {|k,v| v == self }.keys
    end
  end
end
