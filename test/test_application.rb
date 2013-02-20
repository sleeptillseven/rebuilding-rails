require_relative './test_helper'

class TestApp < Rulers::Application
end

class SayController < Rulers::Controller
  def hello
    "Hi from the HelloController"
  end
end

class RulersAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_get_root
    get '/'

    assert_equal 500, last_response.status
  end

  def test_get_say_hello_controller
    get '/say/hello'

    assert last_response.ok?
    body = last_response.body
    assert body["Hello"]
  end

  def test_post_to_root
    post '/new_request', :params => { :id => 100 }

    assert_equal '/new_request', last_request.path
    assert_equal last_request.params['params'], 'id' => '100'
  end
end