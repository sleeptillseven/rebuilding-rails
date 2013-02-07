require "rulers/version"
require "rulers/array"
require "rulers/routing"

module Rulers

  class Application
    def call(env)
      klass, action = get_controller_and_action(env)
      controller = klass.new
      text = controller.send(action)
      [200, {'Content-Type' => 'text/html'}, [text]]
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end