module Builder
  def self.form_for(struct, url = {})
    "<form action='#{url.fetch(:url, '#')}' method='post'>#{}</form>"
  end

  module ClassMethods
    def input(name, options = {})
      @attribute_options ||= {}
      @attribute_options[name] = options
      @attributes = {}

      define_method "#{name}" do
        @attributes[name]
      end
      define_method "#{name}=" do |value|
        @attributes[name] = value
      end

      def as(value, input_type)
        return value if value.nil?

        case input_type
        when :text then String value
        end
      end
    end
  end

  def self.included(base)
    base.attr_reader :input
    base.extend(ClassMethods)
  end

  def initialize(params)
    @attributes = {}

    params.each do |name, value|
      @attributes[name] = value
      value.upcase! if self.class.upcased.include? name
    end
  end
end



User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'rob'

# puts user.name
#=> rob


form_0 = Builder.form_for user do |f|
end

# <form action="#" method="post"></form>

pp form_0; puts



form_0 = Builder.form_for user, url: '/users' do |f|
end

# <form action="/users" method="post"></form>

pp form_0; puts



User_2 = Struct.new(:name, :job, :gender, keyword_init: true)
user = User_2.new(name: 'rob', job: 'hexlet', gender: 'm')



form_1 = Builder.form_for user do |f|
  f.input :name
  f.input :job, as: :text
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>

pp form_1; puts



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