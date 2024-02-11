require 'html_escape'

module HexletCode
  class FormBuilder
    def initialize(object, url: "#", method: "post", **options)
      @object = object
      @url = url
      @method = method
      @options = options
      @fields = []
    end

    def input(key, type: :text, **options)
      @fields << [key, type, HTMLEscape.html_escape(options)]
    end

    def submit(value: "Save")
      @fields << [:submit, :submit, value: HTMLEscape.html_escape(value)]
    end

    def to_html
      html = "<form action='#{@url}' method='#{@method}'#{hash_to_attrs(@options)}>\n"
      @fields.each do |name, type, options|
        label = "<label for='#{name}'>#{name.to_s.capitalize}</label>\n"
        case type
        when :text then
          html += "#{label}<input name='#{name}' type='text' value='#{@object.public_send(name)}'#{hash_to_attrs(options)}>\n"
        when :textarea then
          html += "#{label}<textarea name='#{name}'#{hash_to_attrs(options)}>#{@object.public_send(name)}</textarea>\n"
        else
          raise NotImplementedError, "Input type #{type} not supported yet"
        end
      end
      html += "</form>\n"
    end

    private

    def hash_to_attrs(hash)
      hash.map { |key, value| " #{key}='#{value}'" }.join
    end
  end

  def self.form_for(object, url: "#", method: "post", **options)
    builder = FormBuilder.new(object, url: url, method: method, **options)
    yield builder
    builder.to_html
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
