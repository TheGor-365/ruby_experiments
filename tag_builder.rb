module HexletCode
  class Tag
    def self.build(name, **attributes, &block)
      if block_given?
        content = yield
        "<#{name}#{build_attributes(attributes)}>#{content}</#{name}>"
      else
        "<#{name}#{build_attributes(attributes)}>"
      end
    end

    def self.build_attributes(attributes)
      attributes.map { |attr, value| " #{attr}=\"#{value}\"" }.join
    end
  end
end

# Examples
puts HexletCode::Tag.build('br')
# <br>

puts HexletCode::Tag.build('img', src: 'path/to/image')
# <img src="path/to/image">

puts HexletCode::Tag.build('input', type: 'submit', value: 'Save')
# <input type="submit" value="Save">

# For paired tags, the content is passed as a block
puts HexletCode::Tag.build('label') { 'Email' }
# <label>Email</label>

puts HexletCode::Tag.build('label', for: 'email') { 'Email' }
# <label for="email">Email</label>

puts HexletCode::Tag.build('div')
# <div></div>
