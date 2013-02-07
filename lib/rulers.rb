require "rulers/version"
require "rulers/array"
require "rulers/routing"

module Rulers

  class Application
    HTML    = 'text/html'
    CONTENT = 'Content-Type'

    def call(env)
      if env['PATH_INFO'][/favicon\.ico/]
        return [404, { CONTENT => HTML }, []]
      end

      klass, action = get_controller_and_action(env)
      controller    = klass.new
      text          = controller.send(action)
      [200, { CONTENT => HTML }, [text]]
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end