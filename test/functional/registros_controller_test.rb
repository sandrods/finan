require File.dirname(__FILE__) + '/../test_helper'
require 'registros_controller'

# Re-raise errors caught by the controller.
class RegistrosController; def rescue_action(e) raise e end; end

class RegistrosControllerTest < Test::Unit::TestCase
  fixtures :registros

  def setup
    @controller = RegistrosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:registros)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_registro
    old_count = Registro.count
    post :create, :registro => { }
    assert_equal old_count+1, Registro.count
    
    assert_redirected_to registro_path(assigns(:registro))
  end

  def test_should_show_registro
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_registro
    put :update, :id => 1, :registro => { }
    assert_redirected_to registro_path(assigns(:registro))
  end
  
  def test_should_destroy_registro
    old_count = Registro.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Registro.count
    
    assert_redirected_to registros_path
  end
end
