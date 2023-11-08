require 'date'

class Car
  attr_accessor :attributes

  def initialize(attrs = {})
    @attributes = {}

    @attributes.each do |attribute|
      attribute.attribute_options.each do |name, options|
        value = attrs.key?(name) ? attrs[name] : options.fetch(:default, nil)
        write_attribute(name, value)
      end
    end
  end

  def write_attribute(name, value)
    @attributes.each do |attribute|
      options = attribute.attribute_options[name]
      @attributes[name] = convert(value, options[:type])
    end
  end

  def attribute_options
    @attribute_options || {}
  end

  def attribute(name, options = {})
    @attribute_options ||= {}
    @attribute_options[name] = options

    define_singleton_method "#{name}" do
      @attributes[name]
    end
    define_singleton_method "#{name}=" do |value|
      write_attribute(name, value)
    end

    def convert(value, target_type)
      return value if value.nil?

      case target_type
      when :datetime then DateTime.parse value
      when :string   then String value
      when :integer  then Integer value
      when :boolean  then !!value
      end
    end
  end
end



car = Car.new(
  id:         '1',
  title:      'First Post',
  body:       'Hello, World!',
  created_at: '01/03/2021',
  published:  'true'
)

pp car; puts
pp car.attributes
pp car.attribute_options


puts


pp car.attribute :created_at, type: :datetime
pp car.attribute_options


puts


car.attributes do |c|
  pp c.attribute :created_at, type: :datetime
  pp c.attributes :title, type: :string
  pp c.attribute_options :title, type: :string
end
