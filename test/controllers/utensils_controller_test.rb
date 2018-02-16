require 'test_helper'

class UtensilsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @utensil = utensils(:one)
  end

  test "should get index" do
    get utensils_url
    assert_response :success
  end

  test "should get new" do
    get new_utensil_url
    assert_response :success
  end

  test "should create utensil" do
    assert_difference('Utensil.count') do
      post utensils_url, params: { utensil: { name: @utensil.name, qty: @utensil.qty, recipe_id: @utensil.recipe_id } }
    end

    assert_redirected_to utensil_url(Utensil.last)
  end

  test "should show utensil" do
    get utensil_url(@utensil)
    assert_response :success
  end

  test "should get edit" do
    get edit_utensil_url(@utensil)
    assert_response :success
  end

  test "should update utensil" do
    patch utensil_url(@utensil), params: { utensil: { name: @utensil.name, qty: @utensil.qty, recipe_id: @utensil.recipe_id } }
    assert_redirected_to utensil_url(@utensil)
  end

  test "should destroy utensil" do
    assert_difference('Utensil.count', -1) do
      delete utensil_url(@utensil)
    end

    assert_redirected_to utensils_url
  end
end
