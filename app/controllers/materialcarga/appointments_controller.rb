class Materialcarga::AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_tb_pessoas, only: [:new, :edit, :update, :create]
  before_action :destroyable?, only: [:destroy]
  before_action :get_esq_sec, only: [:new, :edit]

  # GET /appointments
  # GET /appointments.json
  def index    
    if current_user.admin?
      @appointments = Appointment.all
    else
      @appointments = Appointment.verifica_carga_pessoa(current_user.person_id(current_user.username))
      @assisten_appointments = AssistentAppointment.verifica_carga_pessoa(current_user.person_id(current_user.username))
    end  
    authorize @appointments
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    authorize @appointment
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  # GET /appointments/1/edit
  def edit
    authorize @appointment
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    authorize @appointment
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    authorize @appointment
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    authorize @appointment
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  def destroyable?
      if Equipment.exists?(:appointment_id => params[:id])
        respond_to do |format|
          format.html { redirect_to appointments_path, alert: t('flash.notice.dependent') }
        end
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
      #@app_eq = @appointment.equipment.page(params[:page]).per(50)
    end

  def ordena(var)
    if var.present?
     aux = SimsPerson.find(var)
     aux.pespostograd
    else
      "Não cadastrado"
    end
  end

    def get_esq_sec
      aux = Appointment.select(:sims_tba_esq_secao_id).order(sims_tba_esq_secao_id: :asc)
      @valor = "("
      tam = aux.size
      i = 0
      aux.each do |aa|        
        if i == (tam - 1)
          @valor << "#{aa.sims_tba_esq_secao_id}"
        else
          @valor << "#{aa.sims_tba_esq_secao_id},"
        end
        i = i + 1
      end 
      @depart = SimsDepartment.where("esqsec_id not in #{@valor})")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:sims_tba_esq_secao_id, :obs, :person_id, :user_id)     
    end
end
