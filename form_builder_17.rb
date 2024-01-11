module FormBuilder
  def self.form_for(struct, url = {}, *form, &block)
    form << "<form>\n"
    form << yield(struct)
    form << "\n</form>\n"
    form.join
  end
end

public

def input(attr_name, *input, **options)
  FormBuilder.form_for self.to_h do |f|
    input << f[attr_name]
  end
  input
end




User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')


html = FormBuilder.form_for user do |f|
  f.input :name
  f.input :name
  f.input :job, as: :text
end

puts html
