class Array
  def my_map
    ary = []

    self.each do |elem|
      ary << yield(elem)
    end
    ary
  end
end


array = [ 1, 2, 3 ]

show = array.my_map do |item|
  item
  item
end

pp show
