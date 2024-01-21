require 'active_support/all'

module HexletCode
  autoload(:Tag, "./lib/hexlet_code/tag.rb")

  def self.form_for(struct, url = {}, *form)
    form << (url.key?(:url) ? "<form action='#{url.fetch(:url)}' method='post'>\n" : "<form action='#' method='post'>\n")
    form << yield(struct)
    form << "</form>"
    form.join
  end

  def initialize(attributes)
    @attributes = attributes
  end
end




class Struct
  include HexletCode

  def initialize(*params)
    @fields = []
    super
  end

  def input(attr_name, **options)
    public_send(attr_name) unless @attributes[attr_name]

    @field = @attributes.each_with_object({}) do |(name, value), pair|
      pair[name] = case options[:as]
                   when :text then "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
                   else "name='#{name}' type='text' value='#{value}'"
                   end
    end

    case options[:as]
    when :text
      @fields << label(attr_name)
      @fields << "  <textarea "
      @fields << @field.fetch(attr_name)
      @fields << ">"
      @fields << @attributes.fetch(attr_name)
      @fields << "</textarea>\n"
    else
      @fields << label(attr_name)
      @fields << "  <input "
      @fields << @field.fetch(attr_name)
      @fields << (options.map { |name, value| " #{name}='#{value}'" })
      @fields << ">\n"
    end
  end

  def submit(*button_name)
    @fields << "  <input type='submit'"
    @fields << " value='#{button_name.present? ? button_name.join : "Save"}'"
    @fields << ">\n"
    @fields.join
  end

  def label(name, *label)
    label << "  <label for='#{name}'"
    label << ">"
    label << name.to_s.capitalize
    label << "</label>\n"
    label.join
  end
end




User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'rob'

pp user.name; puts
#=> rob


form_0 = HexletCode.form_for(user) { |f| }
# <form action="#" method="post"></form>
pp form_0

form_0 = HexletCode.form_for(user, url: '/users') { |f| }
# <form action="/users" method="post"></form>
pp form_0; puts






Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

form_1 = HexletCode.form_for(user) do |f|
  f.input :name
  f.input :job, as: :text
  # f.input :gender
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>

pp form_1; puts



form_2 = HexletCode.form_for(user, url: '##') do |f|
  f.input :name, class: 'user-input'
  f.input :job
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob" class="user-input">
#   <input name="job" type="text" value="hexlet">
# </form>

pp form_2; puts



form_3 = HexletCode.form_for user, url: '/users' do |f|
  f.input :job, as: :text, rows: 50, cols: 50
end

# <form action="#" method="post">
#   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# </form>

pp form_3; puts




form_4 = HexletCode.form_for user, url: '/users/path' do |f|
  f.input :name
  f.input :job, as: :text
  # f.input :age
end

# =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)

pp form_4; puts



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

pp form_5; puts



form_6 = HexletCode.form_for user, url: '#' do |f|
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

pp form_6; puts
