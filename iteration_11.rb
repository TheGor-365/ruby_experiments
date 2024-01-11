module FormBuilder
  def self.form_for(params, *form)
    yield(params)
  end
end

public

def input(key, *input)
  FormBuilder.form_for self do |f|
    f.fetch(key)
  end
end



params = {
  first:  'one',
  second: 'two',
  third:  'three',
  fourth: 'four',
  fiveth: 'five',
  sixth:  'six'
}

array = []

result = FormBuilder.form_for params do |s|
  s.input :second
  s.input :second
  s.input :first
end

pp result; puts
