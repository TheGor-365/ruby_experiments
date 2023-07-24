class General
  attr_accessor :params

  def initialize params
    @params = params
  end

  def create **params
    yield
    # yield update :second, class: 'ccc'
  end

  def update key, **params
    value = @params[key]
    params_value = params[key]

    @params.merge! params

    init_params = []
    update_params = []
    all_params = []

    init_params << @params.fetch(key, value)
    update_params << params.values.join(' ')

    all_params << init_params
    all_params << update_params

    puts value || params_value ? all_params.join(' ').strip : "no-value #{update_params.join(' ').strip}"
  end
end

general = General.new first: 'one', second: 'two' do |f|
  pp f
end

puts
puts

pp general
pp general.params

puts

general.update :first, class: 'some-class'

puts

general.create do |f|
  # pp f
  # f.update :first, class: 'another-some'
end

puts
puts
puts



module Major

  class << self
    def create **params
      @params = params
      # yield if block_given?
      # yield update :second, class: 'ccc'
    end

    def update key, **params
      value = @params[key]
      params_value = params[key]

      @params.merge! params

      init_params = []
      update_params = []
      all_params = []

      init_params << @params.fetch(key, value)
      update_params << params.values.join(' ')

      all_params << init_params
      all_params << update_params

      puts value || params_value ? all_params.join(' ').strip : "no-value #{update_params.join(' ').strip}"
    end
  end
end

major = Major.create a: 'aa', b: 'bb'
pp major

major_with_block = Major.create c: 'cc', d: 'dd' do |f|
  pp f
end

puts
puts

major_2 = Major.create e: 'ee', g: 'gg' do |f|
  f
end
major_2 = Major.update :g, class: 'wow'
