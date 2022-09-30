require 'forwardable'

User = Struct.new(:first_name, :last_name)

class UserDecorator

  extend Forwardable

  def_delegators :@user, :first_name, :last_name

  def initialize(user)
    @user = user
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

decorated_user = UserDecorator.new(User.new("John", "Doe"))
decorated_user_2 = UserDecorator.new(User.new('Gor', 'Khachatryan'))

puts decorated_user.first_name
puts decorated_user.last_name
puts decorated_user.full_name
puts
puts decorated_user_2.first_name
puts decorated_user_2.last_name
puts decorated_user_2.full_name
