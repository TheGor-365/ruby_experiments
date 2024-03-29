module FormBuilder
  class << self
    attr_accessor :input

    def form_for(struct, *form, **options)
      form << yield(struct)
      form
    end
  end
end

public

def input(key, *input, **options)
  pp key
end



User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

html = FormBuilder.form_for user do |f|
  f.input :name
  f.input :name
  f.input :job, as: :text
end

pp html
