module ModuleName
  class << self
    def tag(tag_name, struct, attributes = nil)
      attr_name = attributes.nil? ? nil : attributes.first
      attr_value = attributes.nil? ? nil : attributes.last

      open_tag = attributes.nil? ? tag_name : "#{tag_name} #{attr_name}=\"#{attr_value}\""
      content = yield
      "<#{open_tag}>#{content}</#{tag_name}>"
    end

    def input(struct, **options)
      options = struct.to_h

      attributes = options.each_with_object({}) do |(name, value), hash|
        case options[:as]
        when :text
          hash[name] = "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
        else
          hash[name] = "name='#{name}' type='text' value='#{value}'"
        end
      end

      case options[:as]
      when :text
        input << "  <textarea "
        input << attributes.fetch(key)
        input << ">"
        input << params.fetch(key)
        input << "</textarea>"
      else
        input << "  <input "
        input << attributes.fetch(key)
        input << (options.map { |option_name, option_value| " #{option_name}='#{option_value}'" })
        input << ">"
      end
      input.join
    end
  end
end


User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'rob'


form = ModuleName.tag 'form', user do |f|
  f
end

puts form
