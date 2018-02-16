class UtensilsController < ApplicationController
  before_action :set_utensil, only: [:show, :edit, :update, :destroy]

  # GET /utensils
  # GET /utensils.json
  def index
    @utensils = Utensil.all
  end

  # GET /utensils/1
  # GET /utensils/1.json
  def show
  end

  # GET /utensils/new
  def new
    @utensil = Utensil.new
  end

  # GET /utensils/1/edit
  def edit
  end

  # POST /utensils
  # POST /utensils.json
  def create
    @utensil = Utensil.new(utensil_params)

    respond_to do |format|
      if @utensil.save
        format.html { redirect_to @utensil, notice: 'Utensil was successfully created.' }
        format.json { render :show, status: :created, location: @utensil }
      else
        format.html { render :new }
        format.json { render json: @utensil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /utensils/1
  # PATCH/PUT /utensils/1.json
  def update
    respond_to do |format|
      if @utensil.update(utensil_params)
        format.html { redirect_to @utensil, notice: 'Utensil was successfully updated.' }
        format.json { render :show, status: :ok, location: @utensil }
      else
        format.html { render :edit }
        format.json { render json: @utensil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /utensils/1
  # DELETE /utensils/1.json
  def destroy
    @utensil.destroy
    respond_to do |format|
      format.html { redirect_to utensils_url, notice: 'Utensil was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_utensil
      @utensil = Utensil.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def utensil_params
      params.require(:utensil).permit(:recipe_id, :name, :qty)
    end
end
