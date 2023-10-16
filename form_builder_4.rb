module InputType
  def initialize attrs = {}
    @attributes = {}

    self.class.attribute_options.each do |name, options|
      value = attrs.key?(name) ? attrs[name] : options.fetch(:default, nil)
      write_attribute(name, value)
    end
  end

  def write_attribute(name, value)
    options = self.class.attribute_options[name]
    @attributes[name] = self.class.convert(value, options[:as])
  end

  module ClassMethods
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
        write_attribute(name, value)
      end

      def convert(value, as)
        return value if value.nil?
        result = []

        case as
        when :text     then result << "<input type='text'>"
        when :textarea then result << "<input type='textarea'>"
        when :submit   then result << "<input type='submit'>"
        end
        result.join
      end
    end
  end

  def self.included(base)
    base.attr_accessor :attributes
    base.extend(ClassMethods)
  end
end


class Form
  include InputType

  attribute :input,  as: :text
  attribute :area,   as: :textarea
  attribute :submit, as: :submit
end


form_1 = Form.new(input: 1, area: 2, submit: 3)

pp form_1

puts

pp form_1.input
pp form_1.area
pp form_1.submit

puts

form_2 = Form.new input: 11 do |f|
  f.input
end

puts

puts form_2
puts form_2.input.inspect
puts form_2.area.inspect
puts form_2.submit.inspect
