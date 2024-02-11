require "minitest/autorun"
# require "minitest/power_assert"

require_relative '../g_builder_3'

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)

  def test_form_with_submit_button
    user = User.new(name: 'rob', job: 'hexlet')

    expected_form = "<form action=\"#\" method=\"post\">" \
                    "<label for=\"name\">Name</label>" \
                    "<input name=\"name\" type=\"text\" value=\"rob\">" \
                    "<label for=\"job\">Job</label>" \
                    "<input name=\"job\" type=\"text\" value=\"hexlet\">" \
                    "<input type=\"submit\" value=\"Save\"></form>"

    actual_form = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job
      f.submit
    end

    assert_equal expected_form, actual_form
  end

  def test_form_with_custom_submit_button_text
    user = User.new(name: 'rob', job: 'hexlet')

    expected_form = "<form action=\"#\" method=\"post\">" \
                    "<label for=\"name\">Name</label>" \
                    "<input name=\"name\" type=\"text\" value=\"rob\">" \
                    "<label for=\"job\">Job</label>" \
                    "<input name=\"job\" type=\"text\" value=\"hexlet\">" \
                    "<input type=\"submit\" value=\"Wow\"></form>"

    actual_form = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end

    assert_equal expected_form, actual_form
  end
end
