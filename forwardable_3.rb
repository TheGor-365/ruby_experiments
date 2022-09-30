require 'forwardable'

class MyQueue

  CONST = 1

  extend Forwardable

  attr_reader :queue

  def initialize
    @queue = []
  end

  def_delegator :@queue, :push, :mypush
  def_delegator 'MyQueue::CONST', :to_i
end

q = MyQueue.new

puts q.mypush 42
puts q.push 42
puts q.queue    #=> [42]
# puts q.push 23  #=> NoMethodError
puts q.to_i
