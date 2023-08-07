class ShoppingList
  def add options
    array = []

    array << 'wow'

    options.each_with_object({}) do |(name, value), hash|
      array << value if name
    end

    puts array.join('  ')
  end

  def items &block
    instance_eval(&block)
  end
end

list = ShoppingList.new

list.add one: 'one 1', two: 'two 2'

puts

list.items do |item|
  pp item
  add three: 'three 3', four: 'four 4'
  item.add five: 'five 5', six: 'six 6'
end
