require 'forwardable'

class RecordCollection
  extend Forwardable

  attr_accessor :records

  def_delegator :@records, :[], :record_number
end


record = RecordCollection.new

pp record.records = [ 4, 5, 6 ]

puts

pp record.record_number(0)
