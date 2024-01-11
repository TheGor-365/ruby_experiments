module FormBuilder
  def self.form_for(options, *form)
    form << "<form>\n"
    form << yield(options)
    form << "</form>\n"
    form
  end
end

public

def input(key, *input)
  input << fetch(key, 'no key')
  input
end




options = {
  first:  'one',
  second: 'two',
  third:  'three',
  fourth: 'four',
  fiveth: 'five',
  sixth:  'six'
}

result = FormBuilder.form_for options do |f|
  f.input :first
  f.input :first
  f.input :third
end

pp result; puts
