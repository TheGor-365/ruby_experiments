require 'active_support/all'

module HexletCode
  class Tag
    def self.build(name, **attributes, &block)
      if block_given?
        content = yield
        "<#{name}#{build_attributes(attributes)}>#{content}</#{name}>"
      else
        "<#{name}#{build_attributes(attributes)}>"
      end
    end

    def self.build_attributes(attributes)
      attributes.map { |attr, value| " #{attr}='#{value}'" }.join
    end
  end

  module FormHelper
    def form_for(struct, **options, &block)
      form_attributes = {
        action: options[:url] || '#',
        method: options[:method] || 'post'
      }
      attributes_str = Tag.build_attributes(form_attributes)
      content = block_given? ? yield(FormBuilder.new(struct)) : ''
      Tag.build('form', **form_attributes) { content }
    end
  end

  class FormBuilder
    def initialize(struct)
      @struct = struct
    end

    def input(name, **options)
      value = @struct.send(name)
      if options[:as] == :text
        Tag.build('textarea', name: name, **options) { value }
      else
        Tag.build('input', name: name, type: 'text', value: value, **options)
      end
    end

    def label(name, **options)
      Tag.build('label', **options) { name.to_s.capitalize }
    end

    def submit(value = 'Save', **options)
      Tag.build('input', type: 'submit', value: value, **options)
    end
  end
end

class Struct
  include HexletCode::FormHelper
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
