require 'test_helper'

class Empenho::EspecificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @especification = especifications(:one)
  end

  test "should get index" do
    get especifications_url
    assert_response :success
  end

  test "should get new" do
    get new_especification_url
    assert_response :success
  end

  test "should create especification" do
    assert_difference('Especification.count') do
      post especifications_url, params: { especification: {  } }
    end

    assert_redirected_to especification_url(Especification.last)
  end

  test "should show especification" do
    get especification_url(@especification)
    assert_response :success
  end

  test "should get edit" do
    get edit_especification_url(@especification)
    assert_response :success
  end

  test "should update especification" do
    patch especification_url(@especification), params: { especification: {  } }
    assert_redirected_to especification_url(@especification)
  end

  test "should destroy especification" do
    assert_difference('Especification.count', -1) do
      delete especification_url(@especification)
    end

    assert_redirected_to especifications_url
  end
end
