require 'test_helper'

class Sims::SimsBigaLicensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sims_biga_license = sims_biga_licenses(:one)
  end

  test "should get index" do
    get sims_biga_licenses_url
    assert_response :success
  end

  test "should get new" do
    get new_sims_biga_license_url
    assert_response :success
  end

  test "should create sims_biga_license" do
    assert_difference('SimsBigaLicense.count') do
      post sims_biga_licenses_url, params: { sims_biga_license: {  } }
    end

    assert_redirected_to sims_biga_license_url(SimsBigaLicense.last)
  end

  test "should show sims_biga_license" do
    get sims_biga_license_url(@sims_biga_license)
    assert_response :success
  end

  test "should get edit" do
    get edit_sims_biga_license_url(@sims_biga_license)
    assert_response :success
  end

  test "should update sims_biga_license" do
    patch sims_biga_license_url(@sims_biga_license), params: { sims_biga_license: {  } }
    assert_redirected_to sims_biga_license_url(@sims_biga_license)
  end

  test "should destroy sims_biga_license" do
    assert_difference('SimsBigaLicense.count', -1) do
      delete sims_biga_license_url(@sims_biga_license)
    end

    assert_redirected_to sims_biga_licenses_url
  end
end
