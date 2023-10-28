module MyModule
  class << self
    def general_method(struct)
      general_array = []

      general_array << "1\n  "
      general_array << yield(secondary_method(struct))
      # general_array << yield('john', 2, third_param)
      # general_array << yield(block)
      general_array << "\n2\n"

      general_array.join
    end

    def secondary_method(options)
      secondary_method = []

      secondary_method << '1 '
      secondary_method << options
      secondary_method << ' 2'

      secondary_method.join
    end
  end
end

User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'rob'


my_object = MyModule.general_method user do |my_param|
  my_param
  my_param.secondary_method
  # my_param.split('').map { |char| '-' + char + '-' }
end

puts my_object
