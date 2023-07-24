def sum *args
  pp yield(args.sum)
end

sum(1, 2) do |param|
  param.to_s
end
puts
puts



module Model
  def self.included base
    base.extend ClassMethods
  end

  attr_accessor :attributes

  module ClassMethods
    attr_reader :upcased

    def up attribute_name
      @upcased ||= []

      define_method "#{attribute_name}" do
        @attributes[attribute_name]
      end
      define_method "#{attribute_name}=" do |value|
        @attributes[attribute_name] = value
        value.upcase! if self.class.upcased.include? attribute_name
      end
      @upcased << attribute_name
    end
  end

  def initialize params
    @attributes = {}

    params.each do |name, value|
      @attributes[name] = value
      value.upcase! if self.class.upcased.include? name
    end
  end
end

class FuckSomebody
  include Model

  up :who

  def self.fuck word
    @result = []
    word = 'fuck'

    @result << word

    pp @result.join(' ')
  end

  def self.who person
    # @result << person.attributes

    # pp @result.join(' ')
  end

  def self.add_or_check_person name
    define_method name do
      instance_variable_get "@#{name}"
    end
    define_method "#{name}=" do |value|
      instance_variable_set "@#{name}", value
    end
  end

  add_or_check_person :me
  add_or_check_person :you
end

someone = FuckSomebody.new(you: 'you', me: 'me')

pp someone.attributes
pp someone.you
pp someone.me

# FuckSomebody.fuck someone do |person|
#   person.who
# end

FuckSomebody.who someone do |person|
  pp person.upcased :you
end
