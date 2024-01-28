require "active_support/all"



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
  autoload(:Tag, "./lib/hexlet_code/tag.rb")

  def self.form_for(struct, *form, **options)
    form << "<form"
    form << (options.key?(:url) ? " action='#{options.fetch(:url)}'" : " action='#'")
    form << (options.key?(:method) ? " method='#{options.fetch(:method)}'" : " method='post'")
    options.each { |key, value| form << " #{key}='#{value}'" if key != :url && key != :method }
    form << ">\n"
    form << yield(struct) if block_given?
    form << "</form>"
    form.join
  end
end



class Struct
  include HexletCode

  def input(key, **options)
    public_send(key) unless to_h[key]
    @input = []

    @field = to_h.each_with_object({}) do |(name, value), pair|
      case options[:as]
      when :text
        pair[name] = "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
      else
        pair[name] = "name='#{name}' type='text' value='#{value}'"
      end
    end
    builder(key, **options)
  end

  def builder(key, **options)
    if options[:as] == :text
      @input << label(key)
      @input << "  <textarea "
      @input << @field.fetch(key)
      @input << ">"
      @input << to_h.fetch(key)
      @input << "</textarea>\n"
    else
      @input << label(key)
      @input << "  <input "
      @input << @field.fetch(key)
      @input << (options.map {|name, value| " #{name}='#{value}'"})
      @input << ">\n"
    end
  end

  def submit(name = nil)
    @input << "  <input type='submit'"
    @input << (" name='#{name.nil? ? "Save" : name}'")
    @input << ">\n"
  end

  def label(name, *label)
    label << "  <label for='#{name}'"
    label << ">"
    label << name.to_s.capitalize
    label << "</label>\n"
    label.join
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
