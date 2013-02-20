module Rulers
  class Controller
    include Controller
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
