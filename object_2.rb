require 'active_support/all'

module HexletCode
  def self.included(base)
    base.class_eval do
      original_method = instance_method(:initialize)

      define_method(:initialize) do |*args, &block|
        original_method.bind(self).call(*args, &block)
      end
    end
  end

  def self.form_for(struct, *form, **options)
    form << yield(struct)
  end
end

class Struct
  def initialize(param)
    @param = param
    @input = []
  end

  def input(key, *input, **options)
    @input << key
  end

  def submit(name = nil)
    @input << (!name.nil? ? name : 'no name')
  end

  include HexletCode
end




User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'rob'

pp user.name; puts
#=> rob


form_0 = HexletCode.form_for(user) { |f| }
# <form action="#" method="post"></form>
puts form_0

form_0 = HexletCode.form_for(user, url: '/users') { |f| }
# <form action="/users" method="post"></form>
puts form_0; puts



User_2 = Struct.new(:name, :job, :gender, keyword_init: true)
user_2 = User_2.new(name: 'rob', job: 'hexlet', gender: 'm')



form_1 = HexletCode.form_for user_2 do |f|
  f.input :name
  f.input :job, as: :text
  f.input :gender
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>

puts form_1; puts



User_3 = Struct.new(:name, :job, :gender, keyword_init: true)
user_3 = User_3.new(name: 'rob', job: 'hexlet', gender: 'm')



form_2 = HexletCode.form_for user_3, url: '##' do |f|
  f.input :name, class: 'user-input'
  f.input :name, class: 'user-input'
  f.input :job
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob" class="user-input">
#   <input name="job" type="text" value="hexlet">
# </form>

puts form_2; puts



User_4 = Struct.new(:name, :job, :gender, keyword_init: true)
user_4 = User_4.new(name: 'rob', job: 'hexlet', gender: 'm')



form_3 = HexletCode.form_for user_4, url: '/users' do |f|
  f.input :job, as: :text, rows: 50, cols: 50
end

# <form action="#" method="post">
#   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# </form>

puts form_3; puts




User_5 = Struct.new(:name, :job, :gender, keyword_init: true)
user_5 = User_5.new(name: 'rob', job: 'hexlet', gender: 'm')




form_4 = HexletCode.form_for user_5, url: '/users/path' do |f|
  f.input :name
  f.input :job, as: :text
  # f.input :age
end
# =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)

puts form_4; puts



User_6 = Struct.new(:name, :job, :gender, keyword_init: true)
user_6 = User_6.new(name: 'rob', job: 'hexlet', gender: 'm')



form_5 = HexletCode.form_for user_6 do |f|
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



User_7 = Struct.new(:name, :job, :gender, keyword_init: true)
user_7 = User_7.new(name: 'rob', job: 'hexlet', gender: 'm')



form_6 = HexletCode.form_for user_7, url: '#' do |f|
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
