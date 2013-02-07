module Rulers
  class Application
    def get_controller_and_action(env)
      _, controller, action, after = env['PATH_INFO'].split('/', 4)
      controller = Object.const_get("#{controller.capitalize}Controller")

      [controller, action]
    end
  end
end