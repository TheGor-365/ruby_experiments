class InputType
  def initialize attrs = {}
    @attributes = {}

    attrs.each do |name, value|
      @attributes[name] = value
    end
  end

  def attribute_options
    @attribute_options || {}
  end

  def attribute(name, options = {})
    @attribute_options ||= {}
    @attribute_options[name] = options

    define_method "#{name}" do
      @attributes[name]
    end

    define_method "#{name}=" do |value|
      @attributes[name] = value
    end

    def convert(value, target_type)
      return value if value.nil?

      case target_type
      when :input
        "<input name='name' type='text' value='value'>"
      when :textarea
        "<input name='name' type='textarea' value='value'>"
      when :submit
        "<input name='name' type='submit' value='value'>"
      end
    end
  end
end
