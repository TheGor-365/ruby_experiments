require 'active_support/all'

module HexletCode
  class Tag
    def self.build(name, **attributes)
      attributes = attributes.map { |attr, value| " #{attr}='#{value}'" }
      tag = []

      tag << "<#{name}"
      tag << attributes.join
      tag << '>' if !unpaired?(name)
      tag << yield if block_given?
      tag << (unpaired?(name) ? ">" : "</#{name}>")
      tag.join
    end

    def self.unpaired?(tag)
      unpaired = %w[ br hr img input meta area base col embed link param source track command keygen menuitem wbr ]
      unpaired.include?(tag) ? true : false
    end
  end
end

pp HexletCode::Tag.build('br')
pp HexletCode::Tag.build('img', src: 'path/to/image')
pp HexletCode::Tag.build('input', type: 'submit', value: 'Save')
pp HexletCode::Tag.build('label') { 'Email' }
pp HexletCode::Tag.build('label', for: 'email') { 'Email' }
pp HexletCode::Tag.build('div')



puts



module HexletCode
  attr_accessor :attributes, :input, :form

  def initialize(params)
    @attributes = {}

    params.each do |name, value|
      @attributes[name] = value
    end
  end

  class << self
    def form_for(struct, url={}, *attributes)
      form = []

      if url.key?(:url)
        url.each_pair do |_name, value|
          form << "<form action='#{value}' method='post'>"
          form << "\n  #{input(struct)}\n"
          form << '</form>'
        end
      else
        form << "<form action='#' method='post'>"
        form << "\n  #{input(struct)}\n"
        form << '</form>'
      end
      form.join
    end

    def input(struct, *attributes)
      input = []

      struct.each_pair do |name, value|
        attributes << "#{name}='#{value}'"
      end

      input << '<input '
      input << attributes.join(' ')
      input << '>'
      input.join
    end
  end
end



User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'rob'

# puts user.name
#=> rob


form_0 = HexletCode.form_for user do |f|
end

# <form action="#" method="post"></form>

pp form_0



form_0 = HexletCode.form_for user, url: '/users' do |f|
end

# <form action="/users" method="post"></form>

pp form_0; puts



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

pp form_1; puts



# form_2 = HexletCode.form_for user, url: '#' do |f|
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
# form_3 = HexletCode.form_for user, url: '/users' do |f|
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
# form_4 = HexletCode.form_for user, url: '/users/path' do |f|
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
# form_5 = HexletCode.form_for user do |f|
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
# form_6 = HexletCode.form_for user, url: '#' do |f|
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
