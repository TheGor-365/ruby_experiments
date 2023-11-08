# -----------------------------------------------------------------
# class Form
# -----------------------------------------------------------------

class Form
  attr_reader :input

  def self.form_for(key, params)
    form = []

    form << "<form action='#' method='post'>"
    form << "\n  #{yield input(key, params)}\n"
    form << '</form>'
    form.join
  end

  def self.input(key, params, **options)
    input = []

    attributes = params.each_with_object({}) do |(name, value), hash|
      hash[name] = "name='#{name}' type='text' value='#{value}'"
    end

    input << '<input '
    input << attributes.fetch(key)
    input << options.values if options
    input << '>'
    input.join
  end
end




user_params = { name: 'rob', job: 'hexlet', gender: 'm' }

form = Form.form_for :name, user_params do |f|
  f
end



puts form; puts



form = Form.input :job, user_params do |f|
  f
end

puts form


puts
p '-' * 100
puts


# -----------------------------------------------------------------
# class HashBacker
# -----------------------------------------------------------------

class HashBacker
  def self.hack(options)
    @array = []

    options.each_pair do |name, value|
      @array << value if yield value
    end
    @array.join(' ')
  end
end

user_params = { name: 'rob', job: 'hexlet', gender: 'm' }

hash_backer = HashBacker.hack user_params do |element|
  element
end

pp hash_backer


puts
p '-' * 100
puts



# -----------------------------------------------------------------
# class FormBuilder
# -----------------------------------------------------------------

class FormBuilder
  def initialize(params)
    @params = params
  end

  def self.form(user, &block)
    form = []
    form << "<form url='/path' method='post'>\n"
    form << yield
    form << '</form>'
    form.join
  end

  def self.input(param_name, **options)
    @params.merge! options
    input = []

    attributes = @params.each_with_object({}) do |(name, value), hash|
      case options[:as]
      when :text
        hash[name] = "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
      else
        hash[name] = "name='#{name}' type='text' value='#{value}'"
      end
    end

    case options[:as]
    when :text
      input << '  <textarea '
      input << attributes.fetch(param_name)
      input << '>'
      input << @params.fetch(param_name)
      input << '</textarea>'
    else
      input << '  <input '
      input << attributes.fetch(param_name)
      input << (options.map { |option_name, value| " #{option_name}='#{value}'" })
      input << '>'
    end
    input.join
  end
end



user = {name: 'rob', job: 'hexlet', gender: 'm'}

form = FormBuilder.form user do |f|
  f.input :job, class: 'www'
  f.input :name
  f.input :gender, as: :text, rows: 56, cols: 77
  f.input :job, as: :text
end

puts form
