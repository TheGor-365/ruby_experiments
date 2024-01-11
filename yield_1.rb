module Builder
  def self.form_for(struct, url = {}, *form, &block)
    form << "<form>\n  "
    form << yield(struct.to_h)
    form << "\n</form>\n"
    form.join
  end
end

public

def input(attr_name, *input, **options)
  params = self

  Builder.form_for self do |f|
    input.push(f.fetch(attr_name))
  end
  input
end




User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'rob'

# puts user.name
#=> rob


form_0 = Builder.form_for user do |f|
end

# <form action="#" method="post"></form>

puts form_0



form_0 = Builder.form_for user, url: '/users' do |f|
end

# <form action="/users" method="post"></form>

puts form_0; puts



User_2 = Struct.new(:name, :job, :gender, keyword_init: true)
user = User_2.new(name: 'rob', job: 'hexlet', gender: 'm')



form_1 = Builder.form_for user do |f|
  f.input :name
  f.input :name
  f.input :job, as: :text
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>

puts form_1; puts



# form_2 = Builder.form_for user, url: '#' do |f|
#   f.input :name, class: 'user-input'
#   f.input :job
# end
#
# # <form action="#" method="post">
# #   <input name="name" type="text" value="rob" class="user-input">
# #   <input name="job" type="text" value="hexlet">
# # </form>
#
# pp form_2; puts
#
#
#
# form_3 = Builder.form_for user, url: '/users' do |f|
#   f.input :job, as: :text, rows: 50, cols: 50
# end
#
# # <form action="#" method="post">
# #   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# # </form>
#
# pp form_3; puts
#
#
#
# form_4 = Builder.form_for user, url: '/users/path' do |f|
#   f.input :name
#   f.input :job, as: :text
#
#   # f.input :age
# end
#
# # =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)
#
# pp form_4; puts
#
#
#
# form_5 = Builder.form_for user do |f|
#   f.input :name
#   f.input :job
#   f.submit
# end
#
# # <form action="#" method="post">
# #   <label for="name">Name</label>
# #   <input name="name" type="text" value="">
# #   <label for="job">Job</label>
# #   <input name="job" type="text" value="hexlet">
# #   <input type="submit" value="Save">
# # </form>
#
# pp form_5; puts
#
#
#
# form_6 = Builder.form_for user, url: '#' do |f|
#   f.input :name
#   f.input :job
#   f.submit 'Wow'
# end
#
# # <form action="#" method="post">
# #   <label for="name">Name</label>
# #   <input name="name" type="text" value="">
# #   <label for="job">Job</label>
# #   <input name="job" type="text" value="hexlet">
# #   <input type="submit" value="Wow">
# # </form>
#
# pp form_6; puts
