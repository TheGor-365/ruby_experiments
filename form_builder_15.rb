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
      unpaired?(name) ? tag << '>' : tag << "</#{name}>"
      tag.join
    end

    def self.unpaired?(tag)
      unpaired = %w[ br hr img input meta area base col embed link param source track command keygen menuitem wbr ]
      unpaired.include?(tag) ? true : false
    end
  end
end

module HexletCode
  class << self
    def form_for struct, url={}, &block
      @params = struct.to_h
      form = []

      if url.key?(:url)
        form << "<form action='#{url.fetch(:url)}' method='post'>\n"
        puts instance_eval(&block)
        # form << yield_self(&block)
        form << "\n</form>"
      else
        form << "<form action='#' method='post'>\n"
        puts instance_eval(&block)
        # form << yield_self(&block)
        form << "\n</form>"
      end
    end

    def input param_name, **field_options
      @names = @params.each_with_object([]) do |(name, value), names|
        names << name if name == param_name
      end
      @names
    end
  end
end


User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')



html = HexletCode.form_for user do |f|
  f.input :name
  f.input :job, as: :text
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>

puts html
puts



html_2 = HexletCode.form_for user, url: '#' do |f|
  f.input :name, class: 'user-input'
  f.input :job
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob" class="user-input">
#   <input name="job" type="text" value="hexlet">
# </form>

puts html_2
puts



html_3 = HexletCode.form_for user, url: '/users' do |f|
  f.input :job, as: :text, rows: 50, cols: 50
end

# <form action="#" method="post">
#   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# </form>

puts html_3
puts



html_4 = HexletCode.form_for user, url: '/users/path' do |f|
  f.input :name
  f.input :job, as: :text

  # f.input :age
end

# =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)

puts html_4
puts
