class Sims::SimsBigaLicensesController < ApplicationController
  before_action :set_sims_biga_license, only: [:show, :edit, :update, :destroy]

  # GET /sims_biga_licenses
  # GET /sims_biga_licenses.json
  def index    
      @sims_biga_licenses = SimsBigaLicense.order(cnh_pes_id: :asc).page(params[:page]).per(20)  
      authorize @sims_biga_licenses   
  end

  def busca_pessoa 
    if params[:busca_people].present?
      if params[:Sel] == '1'
        @sims = PostgresqlViewPerson.select("distinct(id),ncompleto,tipo,cnh,cat,uf").order("ncompleto asc").where(" ncompleto ilike '%#{params[:busca_people]}%'").page(params[:page]).per(20)    
      elsif params[:Sel] == '2'
        @sims = PostgresqlViewPerson.select("distinct(id),ncompleto,tipo,cnh,cat,uf").order("ncompleto asc").where(" placa ilike '%#{params[:busca_people]}%'").page(params[:page]).per(20)      
      else
        @sims = PostgresqlViewPerson.select("distinct(id),ncompleto,tipo,cnh,cat,uf").order("ncompleto asc").where(" ncompleto ilike '%#{params[:busca_people]}%'").page(params[:page]).per(20)    
      end   
    else
      @sims_biga_licenses = SimsBigaLicense.order(cnh_pes_id: :asc).page(params[:page]).per(20)
      render :index
    end
  end

  def busca_pessoa_cad_cnh
    @nomes = PostgresqlViewPerson.select("distinct(ncompleto || ' - ' || tipo || ' - ' || pgabrev || ' - ' || 'CRACHA: '|| COALESCE(pes_cracha_id,0) ) as \"nome\" ").order("nome asc").where("ncompleto ilike ?", "%#{params[:term]}%")
    #@nomes = PostgresqlViewPerson.select("ncompleto as \"nome\"").where("ncompleto ilike ?", "%#{params[:term]}%")
    render json: @nomes.map(&:nome)
  end

  def cnh_vencidas
    @cnhs = SimsBigaLicense.cnh_vencidas
    authorize @cnhs
  end

  # GET /sims_biga_licenses/1
  # GET /sims_biga_licenses/1.json
  def show
    authorize @sims_biga_license
  end

  # GET /sims_biga_licenses/new
  def new
    if params[:format].present?
      @sims_biga_license = SimsBigaLicense.new(cnh_pes_id: params[:format])
      authorize @sims_biga_license
    else
      @sims_biga_license = SimsBigaLicense.new  
      authorize @sims_biga_license
    end    
  end

  # GET /sims_biga_licenses/1/edit
  def edit
    authorize @sims_biga_license
  end

  # POST /sims_biga_licenses
  # POST /sims_biga_licenses.json
  def create
    @sims_biga_license = SimsBigaLicense.new(sims_biga_license_params)
    authorize @sims_biga_license
    respond_to do |format|
      if @sims_biga_license.save
        format.html { redirect_to @sims_biga_license, notice:  t('flash.notice.created') }
        format.json { render :show, status: :created, location: @sims_biga_license }
      else
        format.html { render :new }
        format.json { render json: @sims_biga_license.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sims_biga_licenses/1
  # PATCH/PUT /sims_biga_licenses/1.json
  def update
    authorize @sims_biga_license
    respond_to do |format|
      if @sims_biga_license.update(sims_biga_license_params)
        format.html { redirect_to @sims_biga_license, notice:  t('flash.notice.updated.')  }
        format.json { render :show, status: :ok, location: @sims_biga_license }
      else
        format.html { render :edit }
        format.json { render json: @sims_biga_license.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sims_biga_licenses/1
  # DELETE /sims_biga_licenses/1.json
  def destroy
    authorize @sims_biga_license
    @sims_biga_license.destroy
    respond_to do |format|
      format.html { redirect_to sims_biga_licenses_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sims_biga_license
      @sims_biga_license = SimsBigaLicense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sims_biga_license_params
       params.require(:sims_biga_license).permit(:cnh_pes_id, :cnh_pes_tipo, :cnh_numero, :cnh_validade, :cnh_cat, :cnh_uf)      
    end
end
