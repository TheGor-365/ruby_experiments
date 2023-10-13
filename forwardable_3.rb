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


queue = MyQueue.new

puts queue.mypush 42
puts queue.push 42
puts queue.queue
puts queue.to_i
