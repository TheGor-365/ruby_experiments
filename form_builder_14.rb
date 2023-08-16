class ShoppingList
  def items &block
    array = []

    array << 'wow'
    instance_eval(&block)
    array << 'wow'
    pp array
  end

  def add options
    array = []

    options.each_with_object({}) do |(name, value), hash|
      array << value if name
    end

    puts array.join('  ')
  end
end

list = ShoppingList.new

list.add one: 'one 1', two: 'two 2'

puts

list.items do |item|
  item.add three: 'three 3', four: 'four 4'
  item.add five: 'five 5', six: 'six 6'
end




puts
puts




class ShoppingList
  attr_reader :params
  
  def self.items &block
    array = []

    array << "wow\n"
    array << yield_self(&block)
    array << "\nwow\n"
    array.join
  end

  def self.add options
    @params = []

    options.each_with_object({}) do |(name, value), hash|
      @params << "  #{value}" if name
    end

    pp @params
  end
end


list = ShoppingList.items do |item|
  item.add one: 'one 1', two: 'two 2'
  item.add five: 'five 5', six: 'six 6'
end

puts list
pp ShoppingList.items
