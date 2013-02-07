require "rulers/version"
require "rulers/array"
require "rulers/routing"

module Rulers

  class Application
    CONTENT_TYPE = { 'Content-Type' => 'text/html' }
    OK           = 200
    NOT_FOUND    = [404, CONTENT_TYPE, []]
    SERVER_ERROR = [500, CONTENT_TYPE, []]

    def call(env)
      return NOT_FOUND if get_favicon?(env)
      handle_request(env)
    end


    private

    def get_favicon?(env)
      env['PATH_INFO'][/favicon\.ico/]
    end

    def handle_request(env)
      begin
        [OK, CONTENT_TYPE, [call_action(env)]]
      rescue
        SERVER_ERROR
      end
    end

    def call_action(env)
      klass, action = get_controller_and_action(env)
      controller    = klass.new(env)
      controller.send(action)
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def get?
      !!env['REQUEST_METHOD'][/get/i]
    end

    def post?
      !!env['REQUEST_METHOD'][/post/i]
    end
  end
end