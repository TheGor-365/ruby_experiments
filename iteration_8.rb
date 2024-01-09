require 'benchmark'

class MySymbol
  def initialize(value)
    @value = value
  end

  def to_proc
    proc do |object, *args|
      object.public_send(@value, *args)
    end
  end
end


animals = %w{ant bee cat dog eagle frog girafe horse}

my_upcase_symbol = MySymbol.new(:upcase)

pp animals.map(&my_upcase_symbol); puts








animals = %w{ant bee cat dog eagle frog girafe horse} * 100_000

Benchmark.bmbm(12) do |bm|
  bm.report("&:upcase") do
    animals.map(&:upcase)
  end

  bm.report("String#upcase") do
    animals.map { |animal| animal.upcase }
  end
end
