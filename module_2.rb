module FirstModule
  class << self
    attr_accessor :var
  end
end

pp FirstModule.var
pp FirstModule.var = 'this is saved at @var'
pp FirstModule.var; puts






module SecondModule
  @species = 'frog'
  @color = 'red polka-dotted'
  @log = []

  def self.log(message)
    @log << message
  end

  def self.show_log
    @log.map { |message| message }
  end
end

pp SecondModule.log 'I like cheese'
pp SecondModule.log 'There is no mop'
pp SecondModule.show_log; puts

params = %w[ first second third ]
result = SecondModule.log params

pp result; puts







module ThirdModule
  @log = []

  def self.log(message)
    @log << message
  end

  def self.show_log
    @log.map { |message| message }
  end
end

pp ThirdModule.log 'one'
pp ThirdModule.log 'two'
pp ThirdModule.log 'three'
pp ThirdModule.show_log; puts







module AppConfiguration
  class << self
    attr_accessor :google_api_key
  end

  self.google_api_key = '123456789'
end

pp AppConfiguration.google_api_key
