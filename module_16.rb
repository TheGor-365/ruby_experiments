module HexletCode
  class FormBuilder
    def initialize(object, url: "#", method: "post", **options)
      @object = object
      @url = url
      @method = method
      @options = options
      @fields = []
    end

    def input(name, type: :text, **options)
      @fields << [name, type, HTMLEscape.html_escape(options)]
    end

    def submit(value: "Save")
      @fields << [:submit, :submit, value: HTMLEscape.html_escape(value)]
    end

    def to_html
      html = "<form action='#{@url}' method='#{@method}'#{hash_to_attrs(@options)}>\n"
      @fields.each do |name, type, options|
        label = "<label for='#{name}'>#{name.to_s.capitalize}</label>\n"
        case type
        when :text then
          html += "#{label}<input name='#{name}' type='text' value='#{@object.public_send(name)}'#{hash_to_attrs(options)}>\n"
        when :textarea then
          html += "#{label}<textarea name='#{name}'#{hash_to_attrs(options)}>#{@object.public_send(name)}</textarea>\n"
        else
          raise NotImplementedError, "Input type #{type} not supported yet"
        end
      end
      html += "</form>\n"
    end

    private

    def hash_to_attrs(hash)
      hash.map { |key, value| " #{key}='#{value}'" }.join
    end
  end

  def self.form_for(object, url: "#", method: "post", **options)
    builder = FormBuilder.new(object, url: url, method: method, **options)
    yield builder
    builder.to_html
  end
end




User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: "rob", job: "hexlet", gender: "m")

form_html = HexletCode.form_for(user, url: "/users", class: "my-form") do |f|
  f.input :name, class: "user-input"
  f.input :job, as: :text, rows: 5, cols: 40
  f.submit "Submit"
end

puts form_html
