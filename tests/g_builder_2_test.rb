require "minitest/autorun"
# require "minitest/power_assert"

require_relative '../g_builder_2'

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_form_with_input_fields
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

    expected_form = "<form action=\"#\" method=\"post\">" \
                    "<input name=\"name\" type=\"text\" value=\"rob\">" \
                    "<textarea name=\"job\" cols=\"20\" rows=\"40\">hexlet</textarea></form>"

    actual_form = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job, as: :text
    end

    assert_equal expected_form, actual_form
  end

  def test_form_with_input_fields_and_custom_attributes
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

    expected_form = "<form action=\"#\" method=\"post\">" \
                    "<input name=\"name\" type=\"text\" value=\"rob\" class=\"user-input\">" \
                    "<input name=\"job\" type=\"text\" value=\"hexlet\"></form>"

    actual_form = HexletCode.form_for(user) do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    assert_equal expected_form, actual_form
  end

  def test_form_with_textarea_field_and_custom_attributes
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

    expected_form = "<form action=\"#\" method=\"post\">" \
                    "<textarea name=\"job\" cols=\"50\" rows=\"50\">hexlet</textarea></form>"

    actual_form = HexletCode.form_for(user) do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end

    assert_equal expected_form, actual_form
  end

  def test_form_with_nonexistent_field_raises_error
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

    assert_raises(NoMethodError) do
      HexletCode.form_for(user) do |f|
        f.input :age
      end
    end
  end
end
