require 'minitest/autorun'
require_relative '../module_19'

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_empty_form
    user = User.new(name: "rob", job: "hexlet", gender: "m")

    form = "<form action='#' method='post'>\n</form>"
    builder = HexletCode.form_for(user) { |f| }

    assert_equal form, builder
  end

  def test_empty_form_with_custom_url
    user = User.new(name: "rob", job: "hexlet", gender: "m")

    form = "<form action='/users' method='post'>\n</form>"
    builder = HexletCode.form_for(user, url: "/users") { |f| }

    assert_equal form, builder
  end

  def test_form_with_input_and_textarea_fields
    user = User.new(name: "rob", job: "hexlet", gender: "m")

    form = "<form action='#' method='post'>\n  <label for='name'>Name</label>\n  <input name='name' type='text' value='rob'>\n  <label for='job'>Job</label>\n  <textarea name='job' cols='20' rows='40'>hexlet</textarea>\n</form>"

    builder = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job, as: :text
    end

    assert_equal form, builder
  end

  def test_form_with_input_fields_with_custom_attributes
    user = User.new(name: "rob", job: "hexlet", gender: "m")

    form = "<form action='#' method='post'>\n  <label for='name'>Name</label>\n  <input name='name' type='text' value='rob' class='user-input'>\n  <label for='job'>Job</label>\n  <input name='job' type='text' value='hexlet'>\n</form>"

    builder = HexletCode.form_for(user, url: "#") do |f|
      f.input :name, class: "user-input"
      f.input :job
    end

    assert_equal form, builder
  end

  def test_form_with_attributes_for_textarea
    user = User.new(name: "rob", job: "hexlet", gender: "m")

    form = "<form action='#' method='post'>\n  <label for='job'>Job</label>\n  <textarea name='job' cols='50' rows='50'>hexlet</textarea>\n</form>"

    builder = HexletCode.form_for(user, url: "#") do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end

    assert_equal form, builder
  end

  def test_form_with_submit
    user = User.new(name: "rob", job: "hexlet", gender: "m")

    form = "<form action='#' method='post'>\n  <label for='name'>Name</label>\n  <input name='name' type='text' value='rob'>\n  <label for='job'>Job</label>\n  <input name='job' type='text' value='hexlet'>\n  <input type='submit' value='Save'>\n</form>"

    builder = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job
      f.submit
    end

    assert_equal form, builder
  end

  def test_form_with_submit_custom_name
    user = User.new(name: "rob", job: "hexlet", gender: "m")

    form = "<form action='#' method='post'>\n  <input type='submit' value='Wow'>\n</form>"

    builder = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job
      f.submit "Wow"
    end

    assert_equal form, builder
  end
end
