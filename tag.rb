module HexletCode
  class Tag
    class << self
      def build(name, **attributes)
        attributes = attributes.map { |attr, value| " #{attr}='#{value}'" }
        tag = []

        tag << "<#{name}"
        tag << attributes.join
        tag << ">" unless unpaired?(name)
        tag << yield if block_given?
        tag << (unpaired?(name) ? ">" : "</#{name}>")
        tag.join
      end

      def unpaired?(tag)
        unpaired = %w[ br hr img input meta area base col embed link param source track command keygen menuitem wbr ]
        unpaired.include?(tag) ? true : false
      end
    end
  end
end

pp HexletCode::Tag.build('br')
pp HexletCode::Tag.build('img', src: 'path/to/image')
pp HexletCode::Tag.build('input', type: 'submit', value: 'Save')
pp HexletCode::Tag.build('label') { 'Email' }
pp HexletCode::Tag.build('label', for: 'email') { 'Email' }
pp HexletCode::Tag.build('div')
