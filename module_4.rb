module FormBuilder
  def self.form_for(user)
    yield(user).join("\n")
  end

  def initialize(user)
    @user = user
  end
end


class Struct
  include FormBuilder

  def input(key, **options)
    @params << @user.fetch(key)
  end

  def initialize(user)
    @params = []
    super(user)
  end
end



User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

html = FormBuilder.form_for user do |f|
  f.input :name
  f.input :name
  f.input :job, as: :text
end

pp html
