class Sims::SimsEmployeesController < ApplicationController
  before_action :set_sims_employee, only: [:show, :edit, :update, :destroys]
  before_action :set_tb_pessoas, only: [:show, :edit, :update, :destroy, :new, :create]
  

  # GET /sims_employees
  # GET /sims_employees.json
  def index
    @sims_employees = SimsEmployee.all
    authorize @sims_employees
  end

  def index_inativos_pensionistas
    @sims_employees = SimsEmployee.where("pesestipo ilike '%INATIV%'")
    authorize @sims_employees
  end

  # GET /sims_employees/1
  # GET /sims_employees/1.json
  def show
    authorize @sims_employee
  end

  def update_ativa_cracha
    badge = SimsEmployeeBadge.find(params[:id])   
    badge.update(crachadevolvido: "0")
    redirect_to sims_employee_path(badge.crachapessoa), notice: t('flash.notice.updated.')        
  end

  def update_desativa_cracha
    badge = SimsEmployeeBadge.find(params[:id])    
    badge.update(crachadevolvido: '1' )
    redirect_to sims_employee_path(badge.crachapessoa), notice: t('flash.notice.updated.')  
  end

  def update_validade_cracha
    badge = SimsEmployeeBadge.find(params[:valor])
    employee_word = SimsEmployeeWord.find_by(pesespessoa: badge.crachapessoa)
    if params[:validade].present?      
      badge.update(crachavalidade: params[:validade] )
      employee_word.update(pesesdatafinal: params[:validade] )
      redirect_to sims_employee_path(badge.crachapessoa), notice: t('flash.notice.updated.')
    else
      redirect_to sims_employee_path(badge.crachapessoa), notice: t('flash.notice.invalid.')
    end
  end

  # GET /sims_employees/new
  def new
    @sims_employee = SimsEmployee.new
    authorize @sims_employee
  end

  # GET /sims_employees/1/edit
  def edit
    authorize @sims_employee
  end

  # POST /sims_employees
  # POST /sims_employees.json
  def create
    @sims_employee = SimsEmployee.new(sims_employee_params)
    authorize @sims_employee
    respond_to do |format|
      if @sims_employee.save
        format.html { redirect_to @sims_employee, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @sims_employee }
      else
        format.html { render :new }
        format.json { render json: @sims_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sims_employees/1
  # PATCH/PUT /sims_employees/1.json
  def update
    authorize @sims_employee
    respond_to do |format|
      if @sims_employee.update(sims_employee_params)
        format.html { redirect_to @sims_employee, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @sims_employee }
      else
        format.html { render :edit }
        format.json { render json: @sims_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sims_employees/1
  # DELETE /sims_employees/1.json
  def destroy
    authorize @sims_employee
    @sims_employee.destroy
    respond_to do |format|
      format.html { redirect_to sims_employees_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sims_employee
      @sims_employee = SimsEmployee.find(params[:id])   
      @sims_employee_badges = SimsEmployee.cracha(@sims_employee.pesesid) # para o cracha e tb_estserv_data
      @sims_vehicles = PostgresqlViewPerson.select("placa, marca, modelo, automovel, id, ano, cor, renavam, proprietario, selo").veiculos(params[:id])
      if SimsBigaLicense.exists?(:cnh_pes_id => params[:id])  
        @sims_biga_license = SimsBigaLicense.find_by(cnh_pes_id: params[:id])
        @marc = 0 
      else
        @marc = 1
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sims_employee_params
      params.require(:sims_employee).permit(:pesesnome, :pesesdn, :pesescinum, :pesesciorgao, :pesescpf, :pesesfilpai, :pesesfilmae,
                                            :pesesend, :pesesendnum, :pesesendbairro, :pesesendcidade, :pesesenduf, :pesesendcep,
                                            :pesesfone1, :pesesfone2, :pesestipo, :pesesempresa, :pesesempresacnpj, :pesesfuncao, :pesesatividadeextra,
                                            :peseslocalserv, :pesesint, :pesesintobs, :pesesobs, :pesesdatacad, :pesesuser, :pesesid, :pesesend2,
                                            :pesesempresafone, :pesesdatacadint, :pesesuserint, :pesesmatricula)
    end
end