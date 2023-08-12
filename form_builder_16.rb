require 'active_support/all'

module HexletCode
  autoload(:Tag, "./tag.rb")

  class << self
    def form_for(struct, url = {}, &block)
      @params = struct.to_h

      if url.key?(:url)
        puts "<form action='#{url.fetch(:url)}' method='post'>"
        instance_eval(&block)
        # yield_self if block_given?
        puts "</form>"
      else
        puts "<form action='#' method='post'>"
        instance_eval(&block)
        # yield_self if block_given?
        puts "</form>"
      end
    end

    def input(param_name, **field_options)
      @params.merge! field_options

      @input_attrs = @params.each_with_object({}) do |(name, value), hash|
        case field_options[:as]
        when :text
          hash[name] =
            "name='#{name}' cols='#{field_options.fetch(:cols, 20)}' rows='#{field_options.fetch(:rows, 40)}'"
        else
          hash[name] = "name='#{name}' type='text' value='#{value}'"
        end
      end
      field_constructor(param_name, **field_options)
    end

    def submit(*button_name)
      submit = []

      submit << "  <input type='submit'"
      submit << " name='#{button_name.present? ? button_name.join : 'Save'}'"
      submit << ">"
      puts submit.join
    end

    def field_constructor(param_name, **field_options)
      public_send(param_name) unless @params[param_name]
      field = []

      case field_options[:as]
      when :text
        field << label(param_name)
        field << "  <textarea "
        field << @input_attrs.fetch(param_name)
        field << ">"
        field << @params.fetch(param_name)
        field << "</textarea>"
      else
        field << label(param_name)
        field << "  <input "
        field << @input_attrs.fetch(param_name)
        field_options.map { |option_name, value| field << " #{option_name}='#{value}'" }
        field << ">"
      end
      puts field.join
    end

    def label(param_name)
      label = []

      label << "  <label for='#{param_name.to_s}'"
      label << param_name.to_s.capitalize
      label << "</label>\n"
      label.join
    end
  end
end


User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')



HexletCode.form_for user do |f|
  f.input :name
  f.input :job, as: :text
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>



# HexletCode.form_for user, url: '#' do |f|
#   f.input :name, class: 'user-input'
#   f.input :job
# end
#
# # <form action="#" method="post">
# #   <input name="name" type="text" value="rob" class="user-input">
# #   <input name="job" type="text" value="hexlet">
# # </form>
#
#

# HexletCode.form_for user, url: '/users' do |f|
#   f.input :job, as: :text, rows: 50, cols: 50
# end
#
# # <form action="#" method="post">
# #   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# # </form>



HexletCode.form_for user, url: '/users/path' do |f|
  f.input :name
  f.input :job, as: :text

  # f.input :age
end

# =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)




HexletCode.form_for user do |f|
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



HexletCode.form_for user, url: '#' do |f|
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
