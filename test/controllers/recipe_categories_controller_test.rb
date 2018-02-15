require 'test_helper'

class RecipeCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe_category = recipe_categories(:one)
  end

  test "should get index" do
    get recipe_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_category_url
    assert_response :success
  end

  test "should create recipe_category" do
    assert_difference('RecipeCategory.count') do
      post recipe_categories_url, params: { recipe_category: { category_id: @recipe_category.category_id, recipe_id: @recipe_category.recipe_id } }
    end

    assert_redirected_to recipe_category_url(RecipeCategory.last)
  end

  test "should show recipe_category" do
    get recipe_category_url(@recipe_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_category_url(@recipe_category)
    assert_response :success
  end

  test "should update recipe_category" do
    patch recipe_category_url(@recipe_category), params: { recipe_category: { category_id: @recipe_category.category_id, recipe_id: @recipe_category.recipe_id } }
    assert_redirected_to recipe_category_url(@recipe_category)
  end

  test "should destroy recipe_category" do
    assert_difference('RecipeCategory.count', -1) do
      delete recipe_category_url(@recipe_category)
    end

    assert_redirected_to recipe_categories_url
  end
end
