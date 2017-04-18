class Materialcarga::AssistentAppointmentsController < ApplicationController
  before_action :set_assistent_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_tb_pessoas, only: [:new, :edit, :update, :create]
  before_action :set_appointment, only: [:new, :create]

  # GET /assistent_appointments
  # GET /assistent_appointments.json
  def index
    @assistent_appointments = AssistentAppointment.all
  end

  # GET /assistent_appointments/1
  # GET /assistent_appointments/1.json
  def show
  end

  # GET /assistent_appointments/new
  def new
    @assistent_appointment = AssistentAppointment.new
  end

  # GET /assistent_appointments/1/edit
  def edit
  end

  # POST /assistent_appointments
  # POST /assistent_appointments.json
  def create
    @assistent_appointment = AssistentAppointment.new(assistent_appointment_params)

    respond_to do |format|
      if @assistent_appointment.save
        format.html { redirect_to @assistent_appointment, notice: t('flash.notice.created')}
        format.json { render :show, status: :created, location: @assistent_appointment }
      else
        format.html { render :new }
        format.json { render json: @assistent_appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assistent_appointments/1
  # PATCH/PUT /assistent_appointments/1.json
  def update
    respond_to do |format|
      if @assistent_appointment.update(assistent_appointment_params)
        format.html { redirect_to @assistent_appointment, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @assistent_appointment }
      else
        format.html { render :edit }
        format.json { render json: @assistent_appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assistent_appointments/1
  # DELETE /assistent_appointments/1.json
  def destroy
    @assistent_appointment.destroy
    respond_to do |format|
      format.html { redirect_to assistent_appointments_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assistent_appointment
      @assistent_appointment = AssistentAppointment.find(params[:id])
    end

    def set_appointment
      if current_user
        @appointments = Appointment.verifica_carga_pessoa(current_user.person_id(current_user.username))
      else
        @appointments = Appointment.all
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assistent_appointment_params
      params.require(:assistent_appointment).permit(:person_id, :appointment_id, :obs)      
    end
end
