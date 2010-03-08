require File.dirname(__FILE__) + '/../test_helper'
require 'arquivos_controller'

class ArquivosController; def rescue_action(e) raise e end; end

class ArquivosControllerApiTest < Test::Unit::TestCase
  def setup
    @controller = ArquivosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
end
