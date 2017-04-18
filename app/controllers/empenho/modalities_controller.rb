class Empenho::ModalitiesController < ApplicationController
  before_action :set_modality, only: [:show, :edit, :update, :destroy]
  before_action :destroyable?, only: [:destroy]

  # GET /modalities
  # GET /modalities.json
  def index
    @modalities = Modality.all
  end

  # GET /modalities/1
  # GET /modalities/1.json
  def show
  end

  # GET /modalities/new
  def new
    @modality = Modality.new
     authorize @modality 
  end

  # GET /modalities/1/edit
  def edit
    authorize @modality
  end

  # POST /modalities
  # POST /modalities.json
  def create
    @modality = Modality.new(modality_params)
    authorize @modality
    respond_to do |format|
      if @modality.save
        format.html { redirect_to @modality, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @modality }
      else
        format.html { render :new }
        format.json { render json: @modality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /modalities/1
  # PATCH/PUT /modalities/1.json
  def update
    authorize @modality
    respond_to do |format|
      if @modality.update(modality_params)
        format.html { redirect_to @modality, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @modality }
      else
        format.html { render :edit }
        format.json { render json: @modality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modalities/1
  # DELETE /modalities/1.json
  def destroy
    authorize @modality
    @modality.destroy
    respond_to do |format|
      format.html { redirect_to modalities_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modality
      @modality = Modality.find(params[:id])
    end

    def destroyable?
      if Especification.exists?(:modality_id => params[:id])
        respond_to do |format|
          format.html { redirect_to modalities_path, notice: t('flash.notice.dependent') }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def modality_params
      params.require(:modality).permit(:nome, :obs)
    end
end
