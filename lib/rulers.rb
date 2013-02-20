require File.expand_path(File.dirname(__FILE__) + '/controller.rb')
require 'rulers/version'
require 'rulers/array'
require 'rulers/routing'
require 'rulers/controller'
require 'rulers/http_code'
require 'rulers/util'

module Rulers

  class Application
    include HTTPCode

    CONTENT_TYPE = { 'Content-Type' => 'text/html' }
    NOT_FOUND    = [NOT_FOUND, CONTENT_TYPE, []]
    SERVER_ERROR = [FATAL, CONTENT_TYPE, []]

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
end