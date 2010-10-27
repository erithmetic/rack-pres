!SLIDE

# Rack
### HTTP For Everyone

!SLIDE

# Why?
* Normalized HTTP data
* Separation of concerns
  * Like module mixins

!SLIDE

# HTTP Anatomy
* Just like email
* Action + Headers + Body

!SLIDE

# Demo: curl + nc

!SLIDE

# Rack SPEC
* Object that responds to #call
* \#call takes a single argument, the environment hash
* \#call returns a three-element array that contains:
  * Status code
  * Header key/values
  * Body

!SLIDE

# Demo: Hello World

!SLIDE

# Rack::Builder
* Combine rack apps
* Starting point for Rails Rack Middleware

!SLIDE

# Demo: Rack Builder

!SLIDE

# config.ru
* Server-agnostic Rack::Builder

!SLIDE

# Rails on Rack
@@@ ruby
    # RAILS_ROOT/config.ru
    
    app = Rack::Builder.new {
      use Rails::Rack::LogTailer unless options[:detach]
      use Rails::Rack::Debugger if options[:debugger]
      use ActionDispatch::Static
      run ActionController::Dispatcher.new
    }.to_app
@@@

!SLIDE

# Add your own middleware

@@@ ruby
    # RAILS_ROOT/config/environment.rb
    
    config.middleware.use(new_middleware, args)
@@@

!SLIDE

# Thanks!
* Twitter: @dkastner
* Github: http://github.com/dkastner/rack-pres
