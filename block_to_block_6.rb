module TheModule
  class << self
    def language(options = nil)
      final = []

      final << "1"
      final << yield(options)
      final << "2"
    end
  end
end



options = {
  rb: 'ruby',
  py: 'python',
  js: 'javascript'
}

result = TheModule.language options do |lang|
  lang
  lang
end


puts result
