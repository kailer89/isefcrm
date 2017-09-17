require 'test_helper'

class LlamadasRpmsControllerTest < ActionController::TestCase
  setup do
    @llamadas_rpm = llamadas_rpms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:llamadas_rpms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create llamadas_rpm" do
    assert_difference('LlamadasRpm.count') do
      post :create, llamadas_rpm: { pendientes: @llamadas_rpm.pendientes, por_realizar: @llamadas_rpm.por_realizar, realizadas: @llamadas_rpm.realizadas }
    end

    assert_redirected_to llamadas_rpm_path(assigns(:llamadas_rpm))
  end

  test "should show llamadas_rpm" do
    get :show, id: @llamadas_rpm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @llamadas_rpm
    assert_response :success
  end

  test "should update llamadas_rpm" do
    put :update, id: @llamadas_rpm, llamadas_rpm: { pendientes: @llamadas_rpm.pendientes, por_realizar: @llamadas_rpm.por_realizar, realizadas: @llamadas_rpm.realizadas }
    assert_redirected_to llamadas_rpm_path(assigns(:llamadas_rpm))
  end

  test "should destroy llamadas_rpm" do
    assert_difference('LlamadasRpm.count', -1) do
      delete :destroy, id: @llamadas_rpm
    end

    assert_redirected_to llamadas_rpms_path
  end
end
