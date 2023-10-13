class Backer
  attr_accessor :params

  def initialize params
    @params = params
  end

  def self.back(key, **options)
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



some = {one: 'first', two: 'second'}

pp some
