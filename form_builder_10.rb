module Model
  attr_accessor :attributes

  module ClassMethods
    attr_reader :upcased

    def upcase attribute_name
      @upcased ||= []

      define_method "#{attribute_name}" do
        @attributes[attribute_name]
      end
      define_method "#{attribute_name}=" do |value|
        @attributes[attribute_name] = value
        value.upcase! if self.class.upcased.include? attribute_name
      end

      @upcased << attribute_name
    end
  end

  def initialize params
    @attributes = {}

    params.each do |name, value|
      @attributes[name] = value
      value.upcase! if self.class.upcased.include? name
    end
  end

  def self.included base
    base.extend ClassMethods
  end
end

class Article
  include Model

  upcase :title
  upcase :author
end



article = Article.new(
  title:   'article',
  author:  'John',
  chapter: 'first'
)

pp article
puts

pp article.title
pp article.author
puts

pp article.attributes
puts

pp Article.upcased
puts
puts
puts


class Post
  # extend Model

  attr_accessor :options, :up, :back, :result

  def initialize options
    @options = options
  end

  def self.downcase **options, &block
    pp options
  end

  def self.up **options
    @options = options

    yield
  end

  def back key, **args
    value = @options[key]
    value_2 = args[key]

    @result = []

    @options = @options.merge! args

    @result << @options.fetch(key, value)
    @result << args.values.join(' ')

    case key
    when key
      value || value_2 ? @result : 'no-value'
    end
    @result.join(' ')
  end
end

Post.downcase title: 'post', author: 'Alice', chapter: 'last'
Post.downcase title: 'Post', author: 'Alice', chapter: 'Last' do |p|
  pp p.back :title
  pp p
end

Post.up title: 'the-post', author: 'Alice', chapter: 'Last' do |p|
  # pp p.back :title
  pp p
  pp p
end
puts
puts

post = Post.new title: 'the-post', author: 'Alice', chapter: 'Last'
pp post

post.up do |p|
  pp p
end

post.back :title, author: 'I' do |f|
  pp f
  pp f.downcase
  pp f.up
end
