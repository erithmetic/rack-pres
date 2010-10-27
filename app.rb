require 'rubygems'
require 'rack'
require 'thin'

class HelloWorld
  def call(env)
    [200, { 'Content-Type' =>  'text/html' }, '<html><body><h1>Hello, World!</h1></body></html>']
  end
end

class Cacher
  attr_accessor :cache

  def cache
    @cache ||= {}
  end

  def call(env)
    request = Rack::Request.new env
    if request.post?
      cache[request.params['key']] = request.params['value']
      [201, {'Content-Type' => 'text/plain' }, "Stored #{request.params['key']} => #{request.params['value']}"]
    elsif request.params['key']
      value = cache[request.params['key']] || 'nil'
      [200, { 'Content-Type' =>  'text/plain' }, value]
    else
      [400, { 'Content-Type' => 'text/plain' }, "Sorry, I don't understand" ]
    end
  end
end

app = Rack::Builder.new do
  use Rack::CommonLogger
  use Rack::ShowExceptions
  map '/' do # I don't remember ever having to do this before, but the key was to include a map for the root URL
    run HelloWorld.new
  end
  map '/cache' do
    run Cacher.new
  end
end

Rack::Handler::Thin.run app, :Port => 8080
