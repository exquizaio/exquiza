module Prompt
  mattr_reader(:prompts_path) { Rails.root + "app/models/prompt" }

  class << self

    def included(base)
      base.send :extend, ClassMethods
    end

    def for(type)
      Prompt.const_get("#{type.to_s.classify}Prompt")
    rescue LoadError, NameError
      raise ArgumentError, "Unknown Prompt: #{type}"
    end

    def load(class_or_type)
      return class_or_type if class_or_type.include? Prompt
      Prompt.const_get type.to_s.classify
    end

    def all
      @@prompts ||= load_prompts
    end

    def all_types
      @@prompt_types ||= get_prompt_types
    end

    def params
      all.flat_map(&:params).uniq.push(:type_name)
    end

    private

    def prompt_files
      @@prompt_files ||= Pathname.glob(prompts_path + "*_prompt.rb")
    end

    def get_prompt_types
      prompt_files.map {|f| f.basename("_prompt.rb").to_s }
    end

    def load_prompts
      all_types.map {|s| Prompt.for(s) }
    end

    def loaded_prompts
      constants.select {|c| c.to_s.ends_with? "Prompt" }.map {|p| p.classify }
    end

  end

  def type_name
    self.class.type_name
  end

  def type_name=(new_type)
    #To Satisfy Update Action
  end

  module ClassMethods
    def type_name
      model_name.human.split(" ").first
    end

    def acts_as_promptable?
      true
    end
  end
end
