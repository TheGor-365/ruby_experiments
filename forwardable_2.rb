require 'forwardable'

class RecordCollection
  attr_accessor :records

  extend Forwardable

  # def_delegator :@records, :[], :record_number
  def_delegators :@records, :size, :<<, :map
end

r = RecordCollection.new

p r.records = [1, 2, 3]
# p r.record_number(0)   # => 1
p r.size               # => 3
p r << 4               # => [1, 2, 3, 4]
p r.map { |x| x * 2 }  # => [2, 4, 6, 8]
