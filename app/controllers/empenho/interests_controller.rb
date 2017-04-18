class Empenho::InterestsController < ApplicationController
  before_action :set_interest, only: [:show, :edit, :update, :destroy]

  # GET /interests
  # GET /interests.json
  def index
    @interests = Interest.order(:data_envio)        
  end

  # GET /interests/1
  # GET /interests/1.json
  def show
  end

  # GET /interests/new
  def new
    @interest = Interest.new  
    authorize @interest  
  end

  # GET /interests/1/edit
  def edit
     authorize @interest 
  end

  def abrir_anexo 
    aux = Interest.find(params[:id])    
    send_file aux.avatar.path, 
          filename: aux.avatar_file_name, 
          type: aux.avatar_content_type, 
          disposition: 'attachment' # or 'attachment' 
  end

  # POST /interests
  # POST /interests.json
  def create
    @interest = Interest.new(interest_params)
    authorize @interest
    respond_to do |format|
      if @interest.save
        format.html { redirect_to @interest, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @interest }
      else
        format.html { render :new }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interests/1
  # PATCH/PUT /interests/1.json
  def update
    authorize @interest
    respond_to do |format|
      if @interest.update(interest_params)
        format.html { redirect_to @interest, notice:  t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @interest }
      else
        format.html { render :edit }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interests/1
  # DELETE /interests/1.json
  def destroy
    authorize @interest
    @interest.destroy
    respond_to do |format|
      format.html { redirect_to interests_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest
      @interest = Interest.find(params[:id])      
      @especifications = Especification.where("interest_id = #{params[:id]}")
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def interest_params
      params.require(:interest).permit(:n_empenho, :aplicacao, :rsrp, :obs, :pregao, :company_id, :emissao, :processo, 
                                      :sims_squad_id, :data_envio, :prazo, :avatar, :user_cadastro, :user_atualiza,
                                      :especifications_attributes => [:id, :descricao, :type_id, :qtde, :valor_un, :modality_id, :_destroy])
    end
end
