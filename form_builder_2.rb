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
    def form_for(struct, url = {}, &block)
      @params = struct.to_h
      form = []

      if url.key?(:url)
        form << "<form action='#{url.fetch(:url)}' method='post'>\n"
        form << yield if block_given?
        form << "\n</form>\n"
      else
        form << "<form action='#' method='post'>\n"
        form << yield if block_given?
        form << "\n</form>\n"
      end
      form.join
    end

    def input(param_name, **field_options)
      @params.merge! field_options
      input = []

      @params.each_with_object({}) do |(name, value), hash|
        case field_options[:as]
        when :text
          hash[name] =
            "name='#{name}' cols='#{field_options.fetch(:cols, 20)}' rows='#{field_options.fetch(:rows, 40)}'"
        else
          hash[name] = "name='#{name}' type='text' value='#{value}'"
        end
      end

      @params.map do |name, value|
        if name == param_name
          case field_options[:as]
          when :text
            input << label(param_name)
            input << "  <textarea "
            input << "name='#{name}' cols='#{field_options.fetch(:cols, 20)}' rows='#{field_options.fetch(:rows, 40)}'"
            input << ">"
            input << @params.fetch(param_name)
            input << "</textarea>"
          else
            input << label(param_name)
            input << "  <input "
            input << "name='#{name}' type='text' value='#{value}'"
            input << field_options.map { |option_name, value| " #{option_name}='#{value}'" }
            input << ">"
          end
        end
      end
      input.join
    end

    def submit(*button_name)
      submit = []

      submit << "  <input type='submit'"
      submit << " name='#{button_name.present? ? button_name.join : 'Save'}'>"
    end

    def label(param_name)
      label = []

      label << "  <label for='#{param_name.to_s}'>"
      label << param_name.to_s.capitalize
      label << "</label>\n"
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


# html = HexletCode.form_for user, url: '#' do |f|
#   f.input :name, class: 'user-input'
#   f.input :job
# end
#
# # <form action="#" method="post">
# #   <input name="name" type="text" value="rob" class="user-input">
# #   <input name="job" type="text" value="hexlet">
# # </form>
# print html
#
#
# html = HexletCode.form_for user, url: '/users' do |f|
#   f.input :job, as: :text, rows: 50, cols: 50
# end
#
# # <form action="#" method="post">
# #   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# # </form>
# print html
#
#
# html = HexletCode.form_for user, url: '/users/path' do |f|
#   f.input :name
#   f.input :job, as: :text
#
#   # f.input :age
# end
#
# # =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)
# print html
#
#
#
# html = HexletCode.form_for user do |f|
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
# print html
#
#
# html = HexletCode.form_for user, url: '#' do |f|
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
# print html
