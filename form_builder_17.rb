class FormBuilder
  def initialize params
    @params = params
  end

  def self.form_for struct, &block
    @struct = struct
    form = []

    form << "<form>\n"
    form << yield_self(&block)
    form << "\n</form>\n"
    form.join
  end

  def self.input param_name, *options
    param_name
  end
end


User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

html = FormBuilder.form_for user do |f|
  f.input :name
  f.input :job, as: :text
end

puts html
