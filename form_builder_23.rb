require "active_support/all"

# generates HTML forms
module HexletCode
  def self.form_for(struct, url = {}, &block)
    form = []

    form << (url.key?(:url) ? "<form action='#{url.fetch(:url)}' method='post'>\n" : "<form action='#' method='post'>\n")
    form << yield(struct)
    form << "\n</form>"
    form.join
  end
end

public

def input(param_name, **field_options)
  @params = self.to_h.merge! field_options

  @input_attrs = @params.each_with_object({}) do |(name, value), hash|
    case field_options[:as]
    when :text then hash[name] = "name='#{name}' cols='#{field_options.fetch(:cols, 20)}' rows='#{field_options.fetch(:rows, 40)}'"
    else hash[name] = "name='#{name}' type='text' value='#{value}'"
    end
  end
  field_constructor(param_name, **field_options)
end


def submit(*button_name)
  submit = []
  submit << "  <input type='submit'"
  submit << " name='#{button_name.present? ? button_name.join : "Save"}'"
  submit << '>'
  submit.join
end


def field_constructor(param_name, **field_options)
  public_send(param_name) unless @params[param_name]
  field = []

  case field_options[:as]
  when :text
    field << label(param_name)
    field << '  <textarea '
    field << @input_attrs.fetch(param_name)
    field << '>'
    field << @params.fetch(param_name)
    field << '</textarea>'
  else
    field << label(param_name)
    field << '  <input '
    field << @input_attrs.fetch(param_name)
    field_options.map { |option_name, value| field << " #{option_name}='#{value}'" }
    field << '>'
  end; field.join
end


def label(param_name)
  label = []

  label << "  <label for='#{param_name}'"
  label << param_name.to_s.capitalize
  label << "</label>\n"
  label.join
end





User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'rob'

# puts user.name
#=> rob


form_0 = HexletCode.form_for user do |f|
end

# <form action="#" method="post"></form>

puts form_0



form_0 = HexletCode.form_for user, url: '/users' do |f|
end

# <form action="/users" method="post"></form>

puts form_0; puts



User_2 = Struct.new(:name, :job, :gender, keyword_init: true)
user = User_2.new(name: 'rob', job: 'hexlet', gender: 'm')


form_1 = HexletCode.form_for user do |f|
  f.input :name
  f.input :job, as: :text
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>

puts form_1; puts



form_2 = HexletCode.form_for user, url: '#' do |f|
  f.input :name, class: 'user-input'
  f.input :job
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob" class="user-input">
#   <input name="job" type="text" value="hexlet">
# </form>

puts form_2; puts



form_3 = HexletCode.form_for user, url: '/users' do |f|
  f.input :job, as: :text, rows: 50, cols: 50
end

# <form action="#" method="post">
#   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# </form>

puts form_3; puts



form_4 = HexletCode.form_for user, url: '/users/path' do |f|
  f.input :name
  f.input :job, as: :text

  # f.input :age
end

# =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)

puts form_4; puts



form_5 = HexletCode.form_for user do |f|
  f.input :name
  f.input :job
  f.submit
end

# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input name="name" type="text" value="">
#   <label for="job">Job</label>
#   <input name="job" type="text" value="hexlet">
#   <input type="submit" value="Save">
# </form>

puts form_5; puts



form_6 = HexletCode.form_for user, url: '#' do |f|
  f.input :name
  f.input :job
  f.submit 'Wow'
end

# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input name="name" type="text" value="">
#   <label for="job">Job</label>
#   <input name="job" type="text" value="hexlet">
#   <input type="submit" value="Wow">
# </form>

puts form_6; puts
