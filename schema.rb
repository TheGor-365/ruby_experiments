module HexletCode
  class FormBuilder
    def initialize(struct)
      @struct = struct
      @form_elements = []
    end

    def input(key, **options)
      # Generate input HTML based on key and options
      # Append the generated HTML to @form_elements
    end

    def label(name)
      # Generate label HTML based on name
      # Append the generated HTML to @form_elements
    end

    def submit(name = "Save")
      # Generate submit button HTML
      # Append the generated HTML to @form_elements
    end

    def build_form
      # Build the complete HTML form using @form_elements
    end
  end

  def self.form_for(struct, **options, &block)
    builder = FormBuilder.new(struct)
    yield(builder)
    builder.build_form
  end
end
