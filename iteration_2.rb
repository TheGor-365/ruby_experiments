module FormBuilder
  def self.form_for(options, *form)
    form << "<form>\n"
    form << yield(options)
    form << "</form>\n"
    form.join
  end
end

public

def input(name, *array)
  keys = %i[ first second one ]

  if keys.include?(name)
    array << '  <input '
    array << name
    array << ">\n"
  end
  array
end




options_1 = {
  first:  'one',
  second: 'two',
  third:  'three',
  one:    'one',
  two:    'two',
  three:  'three'
}

result_1 = FormBuilder.form_for options_1 do |f|
  f.input :first
  f.input :first
  f.input :second
end

pp result_1; puts



options_2 = {
  first:  'three',
  second: 'three',
  two:    'three',
  third:  'three',
  one:    'one'
}

# result_2 = FormBuilder.form_for options_2 do |name, value|
#   name.input({name => value})
# end

# pp result_2; puts
