module FormBuilder
  def self.included(host_class)
    host_class.extend ClassMethods
  end

  module ClassMethods
    def form_for
      yield input
    end

    def input
      @input ||= Struct.new
    end
  end

  class Struct
    attr_reader :input
  end
end

class HexletCode
  include FormBuilder
end


User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

result = HexletCode.form_for do |f|
  f.input
  f.input
  f.input
end

pp result; puts

pp HexletCode.input; puts
