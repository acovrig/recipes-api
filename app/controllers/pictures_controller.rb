class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = @recipe.pictures
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.recipe = @recipe

    respond_to do |format|
      if @picture.save
        format.html { redirect_to recipe_picture_path(@recipe, @picture), notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to recipe_picture_path(@recipe, @picture), notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to recipe_pictures_path(@recipe), notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = @recipe.pictures.find_by(id: params[:id])
      redirect_to recipe_pictures_path(@recipe), flash: { alert: "Picture #{params[:id]} not found for #{@recipe.name}" } and return if @picture.nil?
    end

    def set_recipe
      @recipe = current_user.recipes.find_by(id: params[:recipe_id])
      redirect_to recipes_path, flash: { alert: "Recipe #{params[:recipe_id]} not found." } and return if @recipe.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:recipe_id, :fname, :sum, :width, :height, :size, :caption)
    end
end
