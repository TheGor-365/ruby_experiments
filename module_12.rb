module HexletCode
  class Tag
    UNPAIRED_TAGS = %w[br hr img input meta area base col embed link param source track command keygen menuitem wbr].freeze

    def self.build(name, **attributes)
      result = "<#{name}"
      attributes.each { |attr, value| result += " #{attr}='#{value}'" }
      result += UNPAIRED_TAGS.include?(name) ? " />" : ">"
      result += yield if block_given?
      result += "</#{name}>" unless UNPAIRED_TAGS.include?(name)
      result
    end
  end

  def self.form_for(struct, **options, &block)
    form = ["<form"]
    form << (options.key?(:url) ? " action='#{options[:url]}'" : " action='#'")
    form << (options.key?(:method) ? " method='#{options[:method]}'" : " method='post'")
    options.each { |key, value| form << " #{key}='#{value}'" unless [:url, :method].include?(key) }
    form << ">\n"
    form << block.call(struct) if block_given?
    form << "</form>"
    form.join
  end

  module FormHelper
    def input(name, **options)
      raise ArgumentError, "Missing attribute: name" unless name

      field_type = options.delete(:as) || :text

      case field_type
      when :text
        textarea(name, **options)
      else
        text_input(name, **options)
      end
    end

    private

    def text_input(name, **options)
      label = "<label for='#{name}'>#{name.capitalize}</label>"
      input = "<input name='#{name}'"
      input += options.map { |k, v| " #{k}='#{v}'" }.join
      input += ">"
      "#{label}\n#{input}\n"
    end

    def textarea(name, **options)
      label = "<label for='#{name}'>#{name.capitalize}</label>"
      textarea = "<textarea name='#{name}'"
      textarea += options.map { |k, v| " #{k}='#{v}'" }.join
      textarea += ">"
      textarea += yield if block_given?
      textarea += "</textarea>"
      "#{label}\n#{textarea}\n"
    end

    def submit(value = 'Save')
      "<input type='submit' value='#{value}'>"
    end
  end
end

class Struct
  include HexletCode::FormHelper

  def initialize(input)
    @input = []
  end
end

User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

form_0 = HexletCode.form_for(user) {}
puts form_0

form_1 = HexletCode.form_for(user) do |f|
  f.input :name
  f.input :job, as: :text
end
puts form_1

form_2 = HexletCode.form_for(user, url: '##') do |f|
  f.input :name, class: 'user-input'
  f.input :job
end
puts form_2

form_3 = HexletCode.form_for(user, url: '/users') do |f|
  f.input :job, as: :text, rows: 50, cols: 50
end
puts form_3

form_4 = HexletCode.form_for(user, url: '/users/path') do |f|
  f.input :name
  f.input :job, as: :text
  f.input :age
end
puts form_4

form_5 = HexletCode.form_for(user) do |f|
  f.input :name
  f.input :job
  f.submit
end
puts form_5

form_6 = HexletCode.form_for(user, url: '#', method: 'get') do |f|
  f.input :name
  f.input :job
  f.submit 'Wow'
end
puts form_6
