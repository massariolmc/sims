class Empenho::EspecificationsController < ApplicationController
  before_action :set_especification, only: [:show, :edit, :update, :destroy]

  # GET /especifications
  # GET /especifications.json
  def index
    @especifications = Especification.all
  end

  # GET /especifications/1
  # GET /especifications/1.json
  def show
  end

  # GET /especifications/new
  def new
    @especification = Especification.new
  end

  # GET /especifications/1/edit
  def edit
  end

  # POST /especifications
  # POST /especifications.json
  def create
    @especification = Especification.new(especification_params)

    respond_to do |format|
      if @especification.save
        format.html { redirect_to @especification, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @especification }
      else
        format.html { render :new }
        format.json { render json: @especification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /especifications/1
  # PATCH/PUT /especifications/1.json
  def update
    respond_to do |format|
      if @especification.update(especification_params)
        format.html { redirect_to @especification, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @especification }
      else
        format.html { render :edit }
        format.json { render json: @especification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /especifications/1
  # DELETE /especifications/1.json
  def destroy
    @especification.destroy
    respond_to do |format|
      format.html { redirect_to especifications_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_especification
      @especification = Especification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def especification_params
     params.require(:especification).permit(:descricao, :type_id, :qtde, :qtde, :valor_un, :modality_id)
    end
end
