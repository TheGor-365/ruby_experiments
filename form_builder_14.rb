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
  def self.items &block
    array = []

    array << "wow\n"
    array << yield_self(&block)
    array << "wow\n"
    array
  end

  def self.add options
    array = []

    options.each_with_object({}) do |(name, value), hash|
      array << "  #{value}\n" if name
    end

    array.join
  end
end


list = ShoppingList.items do |item|
  item.add three: 'three 3', four: 'four 4'
  item.add five: 'five 5', six: 'six 6'
end

puts list
