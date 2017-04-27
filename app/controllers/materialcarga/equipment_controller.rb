class Materialcarga::EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  before_action :set_esq_sec, only: [:new]
  before_action :change_enum_to_i, only: [:create, :update]

  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = Equipment.all
    authorize @equipment
  end

  # GET /equipment/1
  # GET /equipment/1.json
  def show
    authorize @equipment
  end

  # GET /equipment/new
  def new   
    @equipment = Equipment.new
    authorize @equipment
  end

  # GET /equipment/1/edit
  def edit
    authorize @equipment
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)
    authorize @equipment
    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1
  # PATCH/PUT /equipment/1.json
  def update
    authorize @equipment
    respond_to do |format|      
      if @equipment.update(equipment_params)
        format.html { redirect_to @equipment, notice:  t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    authorize @equipment
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to equipment_index_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
      @equipment = Equipment.find(params[:id])
    end

    def set_esq_sec    
      @appointment = Appointment.find(params[:format])   
    end    

    def change_enum_to_i # SERVE PARA TRANSFORMAR STRING EM INTEIRO
      params[:equipment]["status"] = params[:equipment]["status"].to_i
    end  

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params      
      params.require(:equipment).permit(:nomeclatura, :sigla, :appointment_id, :account_id, :kind_id, :qtde, :bmp, :n_serie, :n_pn, :valor_atualizado, :situation_id, :status, :obs, :user_id)      
    end
end
