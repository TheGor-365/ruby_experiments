module HexletCode
  def self.form_for(struct, **options, &block)
    form_fields = yield(FormBuilder.new(struct))
    url = options.fetch(:url, '#')
    method = options.fetch(:method, 'post')

    form_tag = "<form action='#{url}' method='#{method}'>\n#{form_fields}</form>"
  end

  class FormBuilder
    def initialize(struct)
      @struct = struct
    end

    def input(field, **options)
      label = "<label for='#{field}'>#{field.capitalize}</label>\n"
      input_type = options.fetch(:as, :text)

      case input_type
      when :text
        value = @struct.send(field)
        input_field = "<input name='#{field}' type='text' value='#{value}'>\n"
      when :textarea
        cols = options.fetch(:cols, 20)
        rows = options.fetch(:rows, 40)
        value = @struct.send(field)
        input_field = "<textarea name='#{field}' cols='#{cols}' rows='#{rows}'>#{value}</textarea>\n"
      end

      label + input_field
    end

    def submit(name = 'Save')
      "<input type='submit' value='#{name}'>\n"
    end
  end
end



User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

# User = Struct.new(:name, :job, keyword_init: true)
# user = User.new(name: 'rob')
pp user; puts

form_0 = HexletCode.form_for(user) { |f| }
# <form action="#" method="post"></form>
puts form_0

form_0 = HexletCode.form_for(user, url: '/users') { |f| }
# <form action="/users" method="post"></form>
puts form_0; puts



user = User.new(name: 'rob', job: 'hexlet', gender: 'm')


# User = Struct.new(:name, :job, :gender, keyword_init: true)
# user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

form_1 = HexletCode.form_for(user) do |f|
  f.input :name
  f.input :job, as: :text
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>

puts form_1; puts

user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

form_2 = HexletCode.form_for(user, url: '##') do |f|
  f.input :name, class: 'user-input'
  f.input :job
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob" class="user-input">
#   <input name="job" type="text" value="hexlet">
# </form>

puts form_2; puts

user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

form_3 = HexletCode.form_for user, url: '/users' do |f|
  f.input :job, as: :text, rows: 50, cols: 50
end

# <form action="#" method="post">
#   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# </form>

puts form_3; puts

user = User.new(name: 'rob', job: 'hexlet', gender: 'm')


form_4 = HexletCode.form_for user, url: '/users/path' do |f|
  f.input :name
  f.input :job, as: :text
  # f.input :age
end

# =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)

puts form_4; puts

user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

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

user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

form_6 = HexletCode.form_for user, url: '#', method: 'get' do |f|
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
