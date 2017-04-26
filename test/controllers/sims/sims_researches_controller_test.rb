require 'test_helper'

class Sims::SimsResearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @postgresql_view_person = postgresql_view_people(:one)
  end

  test "should get index" do
    get postgresql_view_people_url
    assert_response :success
  end

  test "should get new" do
    get new_postgresql_view_person_url
    assert_response :success
  end

  test "should create postgresql_view_person" do
    assert_difference('PostgresqlViewPerson.count') do
      post postgresql_view_people_url, params: { postgresql_view_person: {  } }
    end

    assert_redirected_to postgresql_view_person_url(PostgresqlViewPerson.last)
  end

  test "should show postgresql_view_person" do
    get postgresql_view_person_url(@postgresql_view_person)
    assert_response :success
  end

  test "should get edit" do
    get edit_postgresql_view_person_url(@postgresql_view_person)
    assert_response :success
  end

  test "should update postgresql_view_person" do
    patch postgresql_view_person_url(@postgresql_view_person), params: { postgresql_view_person: {  } }
    assert_redirected_to postgresql_view_person_url(@postgresql_view_person)
  end

  test "should destroy postgresql_view_person" do
    assert_difference('PostgresqlViewPerson.count', -1) do
      delete postgresql_view_person_url(@postgresql_view_person)
    end

    assert_redirected_to postgresql_view_people_url
  end
end
