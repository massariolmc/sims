require 'test_helper'

class Sims::SimsEmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sims_employee = sims_employees(:one)
  end

  test "should get index" do
    get sims_employees_url
    assert_response :success
  end

  test "should get new" do
    get new_sims_employee_url
    assert_response :success
  end

  test "should create sims_employee" do
    assert_difference('SimsEmployee.count') do
      post sims_employees_url, params: { sims_employee: {  } }
    end

    assert_redirected_to sims_employee_url(SimsEmployee.last)
  end

  test "should show sims_employee" do
    get sims_employee_url(@sims_employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_sims_employee_url(@sims_employee)
    assert_response :success
  end

  test "should update sims_employee" do
    patch sims_employee_url(@sims_employee), params: { sims_employee: {  } }
    assert_redirected_to sims_employee_url(@sims_employee)
  end

  test "should destroy sims_employee" do
    assert_difference('SimsEmployee.count', -1) do
      delete sims_employee_url(@sims_employee)
    end

    assert_redirected_to sims_employees_url
  end
end
