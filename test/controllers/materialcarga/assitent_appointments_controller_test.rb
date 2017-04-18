require 'test_helper'

class Materialcarga::AssitentAppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assistent_appointment = assistent_appointments(:one)
  end

  test "should get index" do
    get assistent_appointments_url
    assert_response :success
  end

  test "should get new" do
    get new_assistent_appointment_url
    assert_response :success
  end

  test "should create assistent_appointment" do
    assert_difference('AssistentAppointment.count') do
      post assistent_appointments_url, params: { assistent_appointment: {  } }
    end

    assert_redirected_to assistent_appointment_url(AssistentAppointment.last)
  end

  test "should show assistent_appointment" do
    get assistent_appointment_url(@assistent_appointment)
    assert_response :success
  end

  test "should get edit" do
    get edit_assistent_appointment_url(@assistent_appointment)
    assert_response :success
  end

  test "should update assistent_appointment" do
    patch assistent_appointment_url(@assistent_appointment), params: { assistent_appointment: {  } }
    assert_redirected_to assistent_appointment_url(@assistent_appointment)
  end

  test "should destroy assistent_appointment" do
    assert_difference('AssistentAppointment.count', -1) do
      delete assistent_appointment_url(@assistent_appointment)
    end

    assert_redirected_to assistent_appointments_url
  end
end
