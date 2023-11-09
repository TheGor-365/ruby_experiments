require 'forwardable'

User = Struct.new(:first_name, :last_name)

class UserDecorator
  extend Forwardable

  def_delegator :@user, :first_name, :personal_name
  def_delegator :@user, :last_name, :family_name

  def initialize(user)
    @user = user
  end

  def full_name
    "#{personal_name} #{family_name}"
  end
end


decorated_user = UserDecorator.new(User.new('John', 'Doe'))

puts decorated_user.personal_name
