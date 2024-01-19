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
