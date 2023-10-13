Bus = Struct.new(:color, :doors, keyword_init: true)

bus = Bus.new(color: 'Green', doors: 3) do |c|
  pp c.color
  pp c.doors
end

pp bus
puts "color: #{bus.color}\ndoors: #{bus.doors}"
