require 'test_helper'

class Sims::SimsBigaVehiclePeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sims_biga_vehicle_person = sims_biga_vehicle_people(:one)
  end

  test "should get index" do
    get sims_biga_vehicle_people_url
    assert_response :success
  end

  test "should get new" do
    get new_sims_biga_vehicle_person_url
    assert_response :success
  end

  test "should create sims_biga_vehicle_person" do
    assert_difference('SimsBigaVehiclePerson.count') do
      post sims_biga_vehicle_people_url, params: { sims_biga_vehicle_person: {  } }
    end

    assert_redirected_to sims_biga_vehicle_person_url(SimsBigaVehiclePerson.last)
  end

  test "should show sims_biga_vehicle_person" do
    get sims_biga_vehicle_person_url(@sims_biga_vehicle_person)
    assert_response :success
  end

  test "should get edit" do
    get edit_sims_biga_vehicle_person_url(@sims_biga_vehicle_person)
    assert_response :success
  end

  test "should update sims_biga_vehicle_person" do
    patch sims_biga_vehicle_person_url(@sims_biga_vehicle_person), params: { sims_biga_vehicle_person: {  } }
    assert_redirected_to sims_biga_vehicle_person_url(@sims_biga_vehicle_person)
  end

  test "should destroy sims_biga_vehicle_person" do
    assert_difference('SimsBigaVehiclePerson.count', -1) do
      delete sims_biga_vehicle_person_url(@sims_biga_vehicle_person)
    end

    assert_redirected_to sims_biga_vehicle_people_url
  end
end
