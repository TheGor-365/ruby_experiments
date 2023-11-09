module FormBuilder
  def self.form_for(struct, &block)
    @struct = struct
    form = []

    form << "<form>\n"
    form << input(struct)
    form << "\n</form>\n"
    form.join
  end

  def self.input(struct, *options)
    input = []
    params = struct.to_h
    param_name = ''
    value = struct.to_h[param_name]

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
      input << '  <textarea '
      input << attributes.fetch(param_name)
      input << '>'
      input << options.fetch(param_name)
      input << '</textarea>'
    else
      input << '  <input '
      input << attributes.fetch(param_name)
      input << (options.map { |option_name, value| " #{option_name}='#{value}'" })
      input << '>'
    end
    input.join
  end
end



User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')


html = FormBuilder.form_for user do |f|
  f.input :name
  f.input :job, as: :text
end

puts html
