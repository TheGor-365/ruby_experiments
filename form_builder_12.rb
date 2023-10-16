# -----------------------------------------------------------------
# Class General
# -----------------------------------------------------------------

class General
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def self.create(**params)
    yield
  end

  def self.update(key, **params)
    value = @params[key]
    params_value = params[key]

    @params.merge! params

    init_params = []
    update_params = []
    all_params = []

    init_params   << @params.fetch(key, value)
    update_params << params.values.join(' ')

    all_params << init_params
    all_params << update_params

    value || params_value ? all_params.join(' ').strip : "no-value #{update_params.join(' ').strip}"
  end
end

# general = { first: 'one', second: 'two' }
#
# general = General.update general do |f|
#   f
# end
#
# puts
#
# General.update general, class: 'some-class'
#
# puts
#
# General.create general do |f|
#   f
# end
#
# puts




# -----------------------------------------------------------------
# Class Major
# -----------------------------------------------------------------


module Major
  class << self
    def create(**params)
      @params = params
    end

    def update(key, **params)
      value        = @params[key]
      params_value = params[key]

      @params.merge! params

      init_params   = []
      update_params = []
      all_params    = []

      init_params   << @params.fetch(key, value)
      update_params << params.values.join(' ')

      all_params << init_params
      all_params << update_params

      value || params_value ? all_params.join(' ').strip : "no-value #{update_params.join(' ').strip}"
    end
  end
end


# major = { a: 'aa', b: 'bb' }
#
#
# major_without_block = Major.update major
#
# puts major_without_block
#
# major_with_block = Major.update major do |f|
#   f
# end
#
# puts major_with_block
