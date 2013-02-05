require_relative './test_helper'

class TestApp < Rulers::Application
end

class RulersAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_get_root
    get '/'

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