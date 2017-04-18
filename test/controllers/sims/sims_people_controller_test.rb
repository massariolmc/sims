require 'test_helper'

class Sims::SimsPeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sims_sims_person = sims_sims_people(:one)
  end

  test "should get index" do
    get sims_sims_people_url
    assert_response :success
  end

  test "should get new" do
    get new_sims_sims_person_url
    assert_response :success
  end

  test "should create sims_sims_person" do
    assert_difference('Sims::SimsPerson.count') do
      post sims_sims_people_url, params: { sims_sims_person: {  } }
    end

    assert_redirected_to sims_sims_person_url(Sims::SimsPerson.last)
  end

  test "should show sims_sims_person" do
    get sims_sims_person_url(@sims_sims_person)
    assert_response :success
  end

  test "should get edit" do
    get edit_sims_sims_person_url(@sims_sims_person)
    assert_response :success
  end

  test "should update sims_sims_person" do
    patch sims_sims_person_url(@sims_sims_person), params: { sims_sims_person: {  } }
    assert_redirected_to sims_sims_person_url(@sims_sims_person)
  end

  test "should destroy sims_sims_person" do
    assert_difference('Sims::SimsPerson.count', -1) do
      delete sims_sims_person_url(@sims_sims_person)
    end

    assert_redirected_to sims_sims_people_url
  end
end
