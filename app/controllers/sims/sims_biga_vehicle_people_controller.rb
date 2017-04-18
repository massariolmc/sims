class Sims::SimsBigaVehiclePeopleController < ApplicationController
  before_action :set_sims_biga_vehicle_person, only: [:show, :edit, :update, :destroy]

  # GET /sims_biga_vehicle_people
  # GET /sims_biga_vehicle_people.json
  def index
    #@sims_biga_vehicle_people = SimsBigaVehiclePerson.order(vcp_pes_id: :asc).page(params[:page]).per(20)
     @sims_biga_vehicle_people = PostgresqlViewPerson.select("ncompleto || ' - ' || tipo || ' - ' || pgabrev || ' - ' || 'CRACHA: '|| COALESCE(pes_cracha_id,0) as \"nome\", placa, marca, modelo, automovel, id").
                                order("nome asc").where("placa is not null").page(params[:page]).per(100)  
  end

  # GET /sims_biga_vehicle_people/1
  # GET /sims_biga_vehicle_people/1.json
  def show
  end

  # GET /sims_biga_vehicle_people/new
  def new
    @sims_biga_vehicle_person = SimsBigaVehiclePerson.new
  end

  # GET /sims_biga_vehicle_people/1/edit
  def edit
  end

  # POST /sims_biga_vehicle_people
  # POST /sims_biga_vehicle_people.json
  def create
    @sims_biga_vehicle_person = SimsBigaVehiclePerson.new(sims_biga_vehicle_person_params)

    respond_to do |format|
      if @sims_biga_vehicle_person.save
        format.html { redirect_to @sims_biga_vehicle_person, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @sims_biga_vehicle_person }
      else
        format.html { render :new }
        format.json { render json: @sims_biga_vehicle_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sims_biga_vehicle_people/1
  # PATCH/PUT /sims_biga_vehicle_people/1.json
  def update
    respond_to do |format|
      if @sims_biga_vehicle_person.update(sims_biga_vehicle_person_params)
        format.html { redirect_to @sims_biga_vehicle_person, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @sims_biga_vehicle_person }
      else
        format.html { render :edit }
        format.json { render json: @sims_biga_vehicle_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sims_biga_vehicle_people/1
  # DELETE /sims_biga_vehicle_people/1.json
  def destroy
    @sims_biga_vehicle_person.destroy
    respond_to do |format|
      format.html { redirect_to sims_biga_vehicle_people_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sims_biga_vehicle_person
      @sims_biga_vehicle_person = SimsBigaVehiclePerson.find(params[:id])
      @sims = PostgresqlViewPerson.select("ncompleto || ' - ' || tipo || ' - ' || pgabrev || ' - ' || 'CRACHA: '|| COALESCE(pes_cracha_id,0) as \"nome\", placa, marca, modelo, automovel, id, ano, cor, renavam, proprietario, selo").
                                order("nome asc").where(" id = ? and placa is not null", params[:id] )      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sims_biga_vehicle_person_params
      params.require(:sims_biga_vehicle_person).permit(:vcp_id, :vcp_placa_id, :vcp_pes_id, :vcp_pes_tipo, :vcp_posse, :vcp_datacad,
        :vcp_datavinculo, :vcp_datadesvinculo, :vcp_opr_id, :vcp_origem, :vcp_cpf, :vcp_ativo)      
    end
end
