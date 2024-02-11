module HexletCode
  autoload :Tag, 'hexlet_code/tag'

  def self.form_for(entity, **options, &block)
    form_tag = Tag.build('form', action: options.fetch(:url, '#'), method: options.fetch(:method, 'post'))
    yield(form_tag) if block_given?
    form_tag
  end

  def input(name, **options)
    value = public_send(name)
    field_tag = if options[:as] == :text
                  Tag.build('textarea', name: name, cols: options.fetch(:cols, 20), rows: options.fetch(:rows, 40)) { value }
                else
                  Tag.build('input', name: name, type: 'text', value: value)
                end
    @input << field_tag
  end
end
