class ShoppingList
  attr_reader :params

  def self.items(&block)
    array = []

    array << "wow\n"
    array << yield
    array << "\nwow\n"
    array.join
  end

  def self.add(options)
    @params = []

    options.each_with_object({}) do |(name, value), hash|
      @params << "  #{value}" if name
    end
    @params
  end
end


list = ShoppingList.items do |item|
  item.add one: 'one 1', two: 'two 2'
  item.add five: 'five 5', six: 'six 6'
end

puts list

shopping_list = ShoppingList.items do |item|
  item.add ten: 'ten_10'
end

puts shopping_list
