# -----------------------------------------------------------------
# class Form
# -----------------------------------------------------------------


module Form
  def self.form_for(struct, *form)
    some = ''
    form << "<form action='#' method='post'>\n"
    form << yield(struct)
    # struct.to_h.each_with_object({}) do |(name, value), hash|
    #   some = (name)
    # end
    # form << yield(some)
    form << "</form>"
    form.join
  end
end

public

def input(key, *input, **options)
  # attributes = self.each_with_object({}) do |(name, value), hash|
  #   hash[name] = "name='#{name}' type='text' value='#{value}'"
  # end
  pp key

  # input << attributes.fetch(key)
  input << '  <input '
  input << key
  input << ">\n"
end



User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

form = Form.form_for user do |f|
  f.input :name
  f.input :name
  f.input :job, as: :text
end

puts form




puts; p '-' * 10; puts





# -----------------------------------------------------------------
# class HashBacker
# -----------------------------------------------------------------


class HashBacker
  def self.form_for(options, *array)
    options.each_pair do |name, value|
      array << value if yield value
    end
    array.join(' ')
  end
end


user_params = { name: 'rob', job: 'hexlet', gender: 'm' }

hash_backer = HashBacker.form_for user_params do |f|
  f
  f
end

pp hash_backer




puts; p '-' * 10; puts





# -----------------------------------------------------------------
# class FormBuilder
# -----------------------------------------------------------------


class FormBuilder
  def self.form(user, &block)
    form = []
    form << "<form url='/path' method='post'>\n"
    form << yield
    form << "\n</form>"
    form.join
  end
end

public

def input(attr_name, **options)
  input = []

  attributes = options.each_with_object({}) do |(name, value), hash|
    case options[:as]
    when :text then hash[name] = "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
    else hash[name] = "name='#{name}' type='text' value='#{value}'"
    end
  end

  case options[:as]
  when :text
    input << '  <textarea '
    input << attributes.fetch(attr_name, 'no key')
    input << '>'
    input << options.fetch(attr_name, 'no key')
    input << '</textarea>'
  else
    input << '  <input '
    input << attributes.fetch(attr_name, 'no key')
    input << (options.map { |attr_name, value| " #{attr_name}='#{value}'" })
    input << '>'
  end
  input.join
end



user = {name: 'rob', job: 'hexlet', gender: 'm'}

form = FormBuilder.form user do |f|
  f.input :job, class: 'www'
  f.input :name
  f.input :gender, as: :text, rows: 56, cols: 77
  f.input :job, as: :text
end

puts form
