module TheModule
  class << self
    def love_language(options = nil)
      final = []

      final << "1"
      final << yield(options)
      final << "2"
    end
  end
end



options = {ruby: 'ruby'}

result = TheModule.love_language options do |lang|
  lang
  lang
end


puts result
