require 'forwardable'

class RecordCollection

  attr_accessor :records

  extend Forwardable

  def_delegator :@records, :[], :record_number
end

r = RecordCollection.new

p r.records = [4,5,6]
puts
p r.record_number(0)
