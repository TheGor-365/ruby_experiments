Customer = Struct.new(:name, :address) do
  def greeting
    puts self
  end
end

dave = Customer.new("Dave", "123 Main")

Customer.new("Martin", "Madisson street 8").greeting do |attr|
  pp attr.greeting
end
