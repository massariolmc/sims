class Sims::SimsDependentsController < ApplicationController
  before_action :set_sims_dependent, only: [:show, :edit, :update, :destroy]
  before_action :set_tb_pessoas, only: [:show, :edit, :update, :destroy, :new, :create]
  after_action :update_validade_cracha, only: [:update]

  # GET /sims_dependets
  # GET /sims_dependets.json
  def index
    @sims_dependents = SimsDependent.all
    authorize @sims_dependents
  end

  # GET /sims_dependets/1
  # GET /sims_dependets/1.json
  def show
    authorize @sims_dependent
  end

  # GET /sims_dependets/new
  def new
    @sims_dependent = SimsDependent.new
    authorize @sims_dependent
  end

  def update_ativa_cracha
    badge = SimsBadge.find(params[:id])   
    badge.update(crachadevolvido: "0")
    redirect_to sims_dependent_path(badge.crachapessoa), notice: t('flash.notice.updated.')        
  end

  def update_desativa_cracha
    badge = SimsBadge.find(params[:id])    
    badge.update(crachadevolvido: '1' )
    redirect_to sims_dependent_path(badge.crachapessoa), notice: t('flash.notice.updated.')  
  end

  # GET /sims_dependets/1/edit
  def edit
    authorize @sims_dependent
  end

  # POST /sims_dependets
  # POST /sims_dependets.json
  def create
    @sims_dependent = SimsDependent.new(sims_dependet_params)
    authorize @sims_dependent
    respond_to do |format|
      if @sims_dependent.save
        format.html { redirect_to @sims_dependent, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @sims_dependent }
      else
        format.html { render :new }
        format.json { render json: @sims_dependent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sims_dependets/1
  # PATCH/PUT /sims_dependets/1.json
  def update
    authorize @sims_dependent
    respond_to do |format|
      if @sims_dependent.update(sims_dependent_params)
        format.html { redirect_to @sims_dependent, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @sims_dependent }
      else
        format.html { render :edit }
        format.json { render json: @sims_dependent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sims_dependets/1
  # DELETE /sims_dependets/1.json
  def destroy
    authorize @sims_dependent
    @sims_dependent.destroy
    respond_to do |format|
      format.html { redirect_to sims_dependents_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sims_dependent
      @sims_dependent = SimsDependent.find(params[:id])
      @sims_vehicles = PostgresqlViewPerson.select("placa, marca, modelo, automovel, id, ano, cor, renavam, proprietario, selo").veiculos(params[:id])
      #@sims_dependent_badge = SimsDependent.cracha(params[:id])
      if SimsBigaLicense.exists?(:cnh_pes_id => params[:id])  
        @sims_biga_license = SimsBigaLicense.find_by(cnh_pes_id: params[:id])
        @marc = 0 
      else
        @marc = 1
      end
    end

    def update_validade_cracha      
      if params[:sims_dependent][:pes_cracha_id].present?        
        badge = SimsBadge.find(params[:sims_dependent][:pes_cracha_id])                  
        badge.update(crachavalidade: params[:sims_dependent][:pes_cracha_val] )        
      end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sims_dependent_params
      params.require(:sims_dependent).permit(:pesdepnome, :pesdepgrau, :pesdepsexo, :pesdepdn, :pescodigo, :pesdepboletimnum, :pesdepboletimdata,
                                            :pesdepompub, :pesdepradionum, :pesdepradiodata, :pesdepirrf, :pesdeptiposaram, :pesdeptipo,
                                            :pesdepuser, :pesdepdatacad, :pesdepid, :pesdeppesid, :pesdepdatacas, :pes_cracha_id, :pes_cracha_val)      
    end
end
