require 'test_helper'

class Sims::SimsCavVisitorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sims_cav_visitor = sims_cav_visitors(:one)
  end

  test "should get index" do
    get sims_cav_visitors_url
    assert_response :success
  end

  test "should get new" do
    get new_sims_cav_visitor_url
    assert_response :success
  end

  test "should create sims_cav_visitor" do
    assert_difference('SimsCavVisitor.count') do
      post sims_cav_visitors_url, params: { sims_cav_visitor: {  } }
    end

    assert_redirected_to sims_cav_visitor_url(SimsCavVisitor.last)
  end

  test "should show sims_cav_visitor" do
    get sims_cav_visitor_url(@sims_cav_visitor)
    assert_response :success
  end

  test "should get edit" do
    get edit_sims_cav_visitor_url(@sims_cav_visitor)
    assert_response :success
  end

  test "should update sims_cav_visitor" do
    patch sims_cav_visitor_url(@sims_cav_visitor), params: { sims_cav_visitor: {  } }
    assert_redirected_to sims_cav_visitor_url(@sims_cav_visitor)
  end

  test "should destroy sims_cav_visitor" do
    assert_difference('SimsCavVisitor.count', -1) do
      delete sims_cav_visitor_url(@sims_cav_visitor)
    end

    assert_redirected_to sims_cav_visitors_url
  end
end
