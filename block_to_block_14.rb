class Array
  def my_each
    counter = 0

    until counter == self.size
      yield self[counter]
      counter += 1
    end; self
  end
end


test_array = [ 1, 10, 100, 1000, 10000, 100000 ]

show = test_array.my_each do |element|
  pp element.inspect
  pp element
end; puts

pp show
