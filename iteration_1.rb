module FormBuilder
  def self.form_for(options, *form)
    form << "<form>\n"
    options.each { |name, value| form << yield(name) }
    form << "</form>\n"
    form.join
  end
end

public

def input(options, *array)
  keys = %i[ first second third one ]

  options.each do |name, value|
    if keys.include?(name)
      array << '  <input '
      array << name
      array << ">\n"
    end
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

options_2 = {
  first:  'three',
  second: 'three',
}




result_1 = FormBuilder.form_for options_1 do |name, value|
  name.input({name => value})
end
pp result_1; puts

result_2 = FormBuilder.form_for options_2 do |name, value|
  name.input({name => value})
end
pp result_2; puts
