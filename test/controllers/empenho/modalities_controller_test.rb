require 'test_helper'

class Empenho::ModalitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @modality = modalities(:one)
  end

  test "should get index" do
    get modalities_url
    assert_response :success
  end

  test "should get new" do
    get new_modality_url
    assert_response :success
  end

  test "should create modality" do
    assert_difference('Modality.count') do
      post modalities_url, params: { modality: {  } }
    end

    assert_redirected_to modality_url(Modality.last)
  end

  test "should show modality" do
    get modality_url(@modality)
    assert_response :success
  end

  test "should get edit" do
    get edit_modality_url(@modality)
    assert_response :success
  end

  test "should update modality" do
    patch modality_url(@modality), params: { modality: {  } }
    assert_redirected_to modality_url(@modality)
  end

  test "should destroy modality" do
    assert_difference('Modality.count', -1) do
      delete modality_url(@modality)
    end

    assert_redirected_to modalities_url
  end
end
