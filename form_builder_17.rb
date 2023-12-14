module FormBuilder
  def self.form_for(struct, url = {}, &block)
    form = []
    form << "<form>\n"
    form << yield(struct)
    form << "\n</form>\n"
    form.join
  end
end

public

def input(attr_name, **options)
  input = []
  params = self.to_h.merge!(options)

  attributes = params.each_with_object({}) do |(name, value), hash|
    case options[:as]
    when :text then hash[name] = "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
    else hash[name] = "name='#{name}' type='text' value='#{value}'"
    end
  end

  case options[:as]
  when :text
    input << '  <textarea '
    input << attributes.fetch(attr_name, 'no key')
    input << '>'
    input << options.fetch(attr_name, 'no key')
    input << '</textarea>'
  else
    input << '  <input '
    input << attributes.fetch(attr_name, 'no key')
    input << (options.map { |attr_name, value| " #{attr_name}='#{value}'" })
    input << '>'
  end
  input.join
end




User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')


html = FormBuilder.form_for user do |f|
  f.input :name
  f.input :job, as: :text
end

puts html
