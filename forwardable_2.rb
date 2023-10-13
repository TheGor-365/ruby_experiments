require 'forwardable'

class RecordCollection
  attr_accessor :records

  extend Forwardable

  def_delegators :@records, :size, :<<, :map
end


record = RecordCollection.new

pp record.records = [1, 2, 3]
pp record.size               # => 3
pp record << 4               # => [1, 2, 3, 4]
pp record.map { |x| x * 2 }  # => [2, 4, 6, 8]
