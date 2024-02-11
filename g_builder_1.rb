module HexletCode
  class Tag
    def self.build(tag, **attributes, &block)
      result = "<#{tag}"
      attributes.each { |key, value| result += " #{key}='#{value}'" }
      if block_given?
        result += ">"
        result += yield
        result += "</#{tag}>"
      else
        result += "></#{tag}>"
      end
      result
    end
  end

  class FormBuilder
    attr_reader :object, :url

    def initialize(object, url: '#')
      @object = object
      @url = url
      @fields = []
    end

    def input(field, **attributes)
      label = "<label for='#{field}'>#{field.capitalize}</label>"
      input_field = "<input name='#{field}' type='text' value='#{@object.send(field)}'"
      input_field += attributes.map { |k, v| " #{k}='#{v}'" }.join
      input_field += '>'
      @fields << "#{label}\n  #{input_field}"
    end

    def submit(value = 'Save')
      "<input type='submit' value='#{value}'>"
    end

    def render
      form_tag = "<form action='#{@url}' method='post'>\n"
      form_fields = @fields.join("\n")
      form_end = "\n</form>"
      form_tag + form_fields + form_end
    end
  end

  def self.form_for(object, url: '#', **options, &block)
    builder = FormBuilder.new(object, url: url)
    yield builder
    builder.render
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



form_2 = HexletCode.form_for(user, url: '##') do |f|
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
