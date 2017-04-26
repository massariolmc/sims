class Sims::SimsCavVisitorsController < ApplicationController
  before_action :set_sims_cav_visitor, only: [:show, :edit, :update, :destroy]

  # GET /sims_cav_visitors
  # GET /sims_cav_visitors.json
  def index
    if params[:busca_people].present?
      @sims_cav_visitors = SimsCavVisitor.lista_visitantes1(params[:busca_people]).order("cav.tb_visitante_acesso.visacesso_datasai DESC,cav.tb_visitante_acesso.visacesso_horasai DESC,
                            cav.tb_visitante.visitante_nome ASC ").page(params[:page]).per(50)
    else
      @sims_cav_visitors = SimsCavVisitor.lista_visitantes.order("cav.tb_visitante_acesso.visacesso_datasai DESC,cav.tb_visitante_acesso.visacesso_horasai DESC,
                            cav.tb_visitante.visitante_nome ASC ").page(params[:page]).per(50)
    end
    #@sims_cav_visitors = SimsCavVisitor.all
  end

  # GET /sims_cav_visitors/1
  # GET /sims_cav_visitors/1.json
  def show
  end

  # GET /sims_cav_visitors/new
  def new
    @sims_cav_visitor = SimsCavVisitor.new
  end

  # GET /sims_cav_visitors/1/edit
  def edit
  end

  # POST /sims_cav_visitors
  # POST /sims_cav_visitors.json
  def create
    @sims_cav_visitor = SimsCavVisitor.new(sims_cav_visitor_params)

    respond_to do |format|
      if @sims_cav_visitor.save
        format.html { redirect_to @sims_cav_visitor, notice: 'Sims cav visitor was successfully created.' }
        format.json { render :show, status: :created, location: @sims_cav_visitor }
      else
        format.html { render :new }
        format.json { render json: @sims_cav_visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sims_cav_visitors/1
  # PATCH/PUT /sims_cav_visitors/1.json
  def update
    respond_to do |format|
      if @sims_cav_visitor.update(sims_cav_visitor_params)
        format.html { redirect_to @sims_cav_visitor, notice: 'Sims cav visitor was successfully updated.' }
        format.json { render :show, status: :ok, location: @sims_cav_visitor }
      else
        format.html { render :edit }
        format.json { render json: @sims_cav_visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sims_cav_visitors/1
  # DELETE /sims_cav_visitors/1.json
  def destroy
    @sims_cav_visitor.destroy
    respond_to do |format|
      format.html { redirect_to sims_cav_visitors_url, notice: 'Sims cav visitor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sims_cav_visitor
      @sims_cav_visitor = SimsCavVisitor.find(params[:id])
      @sims_cav_visitor_vehicle = SimsCavVisitor.visitante(params[:id]).order("cav.tb_visitante_acesso.visacesso_dataent DESC ")
      @sims_cav_vehicle = SimsCavVehicle.carros(params[:id])
      
      if SimsBigaLicense.exists?(:cnh_pes_id => params[:id])  
        @sims_biga_license = SimsBigaLicense.find_by(cnh_pes_id: params[:id])
        @marc = 0 
      else
        @marc = 1
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sims_cav_visitor_params
      params.fetch(:sims_cav_visitor, {})
    end
end
