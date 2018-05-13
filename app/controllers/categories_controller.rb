class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @per_page = (params[:per_page] ? params[:per_page] : 50)
    @categories = Category.all.paginate(page: params[:page], per_page: @per_page)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @recipes = @category.recipes
    if user_signed_in?
      @recipes = @recipes.where('privacy IN (?) OR author_id = ?', %w(public internal), current_user.id)
    else
      @recipes = @recipes.where(privacy: 'public')
    end
    @per_page = (params[:per_page] ? params[:per_page] : 50)
    @recipes = @recipes.paginate(page: params[:page], per_page: @per_page)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    redirect_to root_path and return if @category.created_by != current_user
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @category.created_by = current_user

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    redirect_to root_path and return if @category.created_by != current_user
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    redirect_to root_path and return if @category.created_by != current_user
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
