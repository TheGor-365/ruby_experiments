class Backer
  def back collection
    @collection = []

    collection.each do |element|
      @collection << element if yield element
    end
  end
end

collection = %w[ one two three four ]

backer = Backer.new

backer.back collection do |element|
  pp element.upcase if element[0] == 'o'
  pp element.upcase if element[0] == 'f'
end

puts
puts
puts



class Form
  attr_reader :input

  def form_for key, params
    @form = []

    @form << "<form action='#' method='post'>"
    @form << "\n\t#{yield input(key, params)}\n"
    @form << '</form>'

    puts @form.join
  end

  def input key, params, **options
    @input = []

    attributes = params.each_with_object({}) do |(name, value), hash|
      hash[name] = "name='#{name}' type='text' value='#{value}'"
    end

    value = attributes[key]

    @input << '<input '
    @input << attributes.fetch(key)
    @input << options.values if options
    @input << '>'

    puts @input.join
  end
end

user_params = { name: 'rob', job: 'hexlet', gender: 'm' }
form = Form.new
pp form

puts

form.form_for :name, user_params do |f|
  f
end

puts

form.input :job, user_params do |f|
  f
end

puts
puts
puts



class HashBacker
  def hack options
    @options = {}

    options.each_with_object([]) do |(name, value), array|
      array << value if yield value
    end
  end
end

user_params = { name: 'rob', job: 'hexlet', gender: 'm' }

hash_backer = HashBacker.new

hash_backer.hack user_params do |element|
  pp element.upcase if element[0] == 'h'
  pp element
end

puts
puts
puts



class FormBuilder
  def initialize params
    @params = params
  end

  def form &block
    print "<form url='/path' method='post'>\n"
    print instance_eval(&block)
    print '</form>'
  end

  def input param_name, **options
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
      options.map { |option_name, value| input << " #{option_name}='#{value}'" }
      input << '>'
    end

    puts input.join
  end
end


user = FormBuilder.new name: 'rob', job: 'hexlet', gender: 'm'

user.form do |f|
  f.input :job, class: 'www'
  f.input :name
  f.input :gender, as: :text, rows: 56, cols: 77
  f.input :job, as: :text
end


puts
puts
puts



class FormBuilder
  def initialize params
    @params = params
  end

  def form &block
    form = []
    form << "<form url='/path' method='post'>\n"
    form << instance_eval(&block)
    form << '</form>'
    pp form
  end

  def input param_name, **options
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
      options.map { |option_name, value| input << " #{option_name}='#{value}'" }
      input << '>'
    end
    puts input
  end
end


user = FormBuilder.new name: 'rob', job: 'hexlet', gender: 'm'

user.form do |f|
  f.input :job, class: 'www'
  f.input :name
  f.input :gender, as: :text, rows: 56, cols: 77
  f.input :job, as: :text
end
