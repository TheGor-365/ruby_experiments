def form_for(struct)
  yield(struct)
end

public

def input(key, *input, **options)
  form_for self do |f|
    input << f.to_h.fetch(key)
  end
  input
end



User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

html = form_for user do |f|
  f.input :name
  f.input :name
  f.input :job, as: :text
end

pp html
