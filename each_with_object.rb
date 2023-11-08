require 'forwardable'
require 'uri'

class Url
  extend Forwardable
  include Comparable

  def_delegators :@uri, :scheme, :host, :to_s, :query, :decode_www_form

  def initialize(uri)
    @uri = URI(uri)
  end

  def query_params
    if @uri.to_s.include?('?')
      # @params = uri.query.split('&').map { |el| el.split('=') }.each_with_object({}) do |item, hash|
      #             hash[item[0].to_sym] = item[1]
      #           end
      @params = @uri.query.split('&').each_with_object({}) do |item, hash|
        hash[item.split('=')[0].to_sym] = item.split('=')[1]
      end
    else
      @params = {}
    end
  end

  def query_param(key, value = nil)
    query_params
    @params.fetch(key.to_sym, value)
  end

  def <=>(other)
    @uri <=> other
  end
end



yandex_url = Url.new 'http://yandex.ru?key=value&key2=value2'
google_url = Url.new 'https://google.com:80?a=b&c=d&lala=value'

pp yandex_url; puts

pp yandex_url.query
pp yandex_url.query_params
pp yandex_url == google_url
