class Backer
  attr_accessor :params

  def initialize params
    @params = params
  end

  def back key, **options
    value = @params[key]
    value_2 = options[key]

    @params = @params.merge! options

    params_values = []
    attributes_values = []
    all_values = []

    params_values << @params.fetch(key, value)
    attributes_values << options.values.join(' ')

    all_values << params_values
    all_values << attributes_values

    value || value_2 ? all_values.join(' ').strip : "no-params-value #{attributes_values.join(' ').strip}"
  end
end



backer = Backer.new one: 'first', two: 'second'

pp backer
pp backer.back :one
pp backer.back :two
pp backer.back :three
puts

pp backer.params
puts
puts

pp backer.back :one, class: 'text-muted'
pp backer.back :two, class: 'text-muted', attribute_name: 'attribute_value'
pp backer.back :four, class: 'text-muted'
puts

pp backer
puts

pp backer.params
puts
puts


second_backer = Backer.new two: 'second', next: 'the-next' do |f|
  pp f
end

second_backer.back :two do |b|
  pp b
end
