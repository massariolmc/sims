require 'test_helper'

class Sims::SimsDependentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sims_dependet = sims_dependets(:one)
  end

  test "should get index" do
    get sims_dependets_url
    assert_response :success
  end

  test "should get new" do
    get new_sims_dependet_url
    assert_response :success
  end

  test "should create sims_dependet" do
    assert_difference('SimsDependet.count') do
      post sims_dependets_url, params: { sims_dependet: {  } }
    end

    assert_redirected_to sims_dependet_url(SimsDependet.last)
  end

  test "should show sims_dependet" do
    get sims_dependet_url(@sims_dependet)
    assert_response :success
  end

  test "should get edit" do
    get edit_sims_dependet_url(@sims_dependet)
    assert_response :success
  end

  test "should update sims_dependet" do
    patch sims_dependet_url(@sims_dependet), params: { sims_dependet: {  } }
    assert_redirected_to sims_dependet_url(@sims_dependet)
  end

  test "should destroy sims_dependet" do
    assert_difference('SimsDependet.count', -1) do
      delete sims_dependet_url(@sims_dependet)
    end

    assert_redirected_to sims_dependets_url
  end
end
