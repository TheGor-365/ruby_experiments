module Builder
  class << self
    def tag(struct, attributes = nil)
      "<form>#{yield}</form>"
    end

    def input(struct, **options)
      options = struct.to_h

      attributes = options.each_with_object({}) do |(name, value), hash|
        case options[:as]
        when :text
          hash[name] = "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
        else
          hash[name] = "name='#{name}' type='text' value='#{value}'"
        end
      end

      case options[:as]
      when :text
        input << "  <textarea "
        input << attributes.fetch(key)
        input << ">"
        input << params.fetch(key)
        input << "</textarea>"
      else
        input << "  <input "
        input << attributes.fetch(key)
        input << (options.map { |option_name, option_value| " #{option_name}='#{option_value}'" })
        input << ">"
      end
      input.join
    end
  end
end



User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'rob'

# puts user.name
#=> rob


form_0 = Builder.tag user do |f|
end

# <form action="#" method="post"></form>

pp form_0; puts



form_0 = Builder.tag user, url: '/users' do |f|
end

# <form action="/users" method="post"></form>

pp form_0; puts



User_2 = Struct.new(:name, :job, :gender, keyword_init: true)
user = User_2.new(name: 'rob', job: 'hexlet', gender: 'm')



form_1 = Builder.tag user do |f|
  f.input :name
  f.input :job, as: :text
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>

pp form_1; puts



# form_2 = Builder.tag user, url: '#' do |f|
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
# form_3 = Builder.tag user, url: '/users' do |f|
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
# form_4 = Builder.tag user, url: '/users/path' do |f|
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
# form_5 = Builder.tag user do |f|
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
# form_6 = Builder.tag user, url: '#' do |f|
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
