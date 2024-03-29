# --------------------------------------------------------------
# module InputType
# --------------------------------------------------------------

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

pp form_1.input
pp form_1.area
pp form_1.submit; puts



# --------------------------------------------------------------
# Class NewForm
# --------------------------------------------------------------


class NewForm
  extend InputType
end



form_2 = NewForm.new do |f|
  pp f.inspect
end



pp form_2
