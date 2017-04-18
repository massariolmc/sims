require 'test_helper'

class Sims::SimsEmployeeWordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sims_employee_word = sims_employee_words(:one)
  end

  test "should get index" do
    get sims_employee_words_url
    assert_response :success
  end

  test "should get new" do
    get new_sims_employee_word_url
    assert_response :success
  end

  test "should create sims_employee_word" do
    assert_difference('SimsEmployeeWord.count') do
      post sims_employee_words_url, params: { sims_employee_word: {  } }
    end

    assert_redirected_to sims_employee_word_url(SimsEmployeeWord.last)
  end

  test "should show sims_employee_word" do
    get sims_employee_word_url(@sims_employee_word)
    assert_response :success
  end

  test "should get edit" do
    get edit_sims_employee_word_url(@sims_employee_word)
    assert_response :success
  end

  test "should update sims_employee_word" do
    patch sims_employee_word_url(@sims_employee_word), params: { sims_employee_word: {  } }
    assert_redirected_to sims_employee_word_url(@sims_employee_word)
  end

  test "should destroy sims_employee_word" do
    assert_difference('SimsEmployeeWord.count', -1) do
      delete sims_employee_word_url(@sims_employee_word)
    end

    assert_redirected_to sims_employee_words_url
  end
end
