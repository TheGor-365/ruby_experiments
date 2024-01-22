require 'active_support/all'

module HexletCode
  class Tag
    def self.build(name, *tag, **attributes)
      attributes = attributes.map { |attr, value| " #{attr}='#{value}'" }

      tag << "<#{name}"
      tag << attributes.join
      tag << '>' unless unpaired?(name)
      tag << yield if block_given?
      tag << (unpaired?(name) ? '>' : "</#{name}>")
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
pp HexletCode::Tag.build('div'); puts




module HexletCode
  def self.form_for(struct, url = {}, *form)
    form << (url.key?(:url) ? "<form action='#{url.fetch(:url)}' method='post'>\n" : "<form action='#' method='post'>\n")
    form << yield(struct)
    form << '</form>'
    form.join
  end

  def initialize(attributes)
    @attributes = attributes
  end
end





class Struct
  include HexletCode

  def initialize(attributes)
    super
    @fields = []
  end

  def input(key, *input, **options)
    public_send(key) unless @attributes[key]

    @field = @attributes.each_with_object({}) do |(name, value), hash|
      case options[:as]
      when :text then hash[name] = "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
      else hash[name] = "name='#{name}' type='text' value='#{value}'"
      end
    end

    case options[:as]
    when :text
      @fields << label(key)
      @fields << '  <textarea '
      @fields << @field.fetch(key)
      @fields << '>'
      @fields << @attributes.fetch(key)
      @fields << "</textarea>\n"
    else
      @fields << label(key)
      @fields << '  <input '
      @fields << @field.fetch(key)
      @fields << (options.map { |name, value| " #{name}='#{value}'" })
      @fields << ">\n"
      @fields
    end
  end

  def submit(*button_name)
    @fields << "  <input type='submit'"
    @fields << " value='#{button_name.present? ? button_name.join : 'Save'}'"
    @fields << ">\n"
    @fields.join
  end


  def label(name, *label)
    label << "  <label for='#{name}'"
    label << '>'
    label << name.to_s.capitalize
    label << "</label>\n"
    label.join
  end
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



User_3 = Struct.new(:name, :job, :gender, keyword_init: true)
user_3 = User_3.new(name: 'rob', job: 'hexlet', gender: 'm')



form_2 = HexletCode.form_for user_3, url: '##' do |f|
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
