class Sims::SimsPeopleController < ApplicationController
  before_action :set_sims_person, only: [:show, :edit, :update, :destroy, :sims_dependent_all]
  before_action :set_tb_pessoas, only: [:new, :show, :edit, :update, :destroy, :create, :sims_dependent_all]
  after_action :update_validade_cracha, only: [:update]

  # GET /sims/sims_people
  # GET /sims/sims_people.json
  def index
    @sims_people = SimsPerson.where("pessituacao = 4")
    authorize @sims_people
  end

  def index_desligados
    @sims_people = SimsPerson.where("pessituacao <> 4")
    authorize @sims_people
  end

  def tipo_permission_login
    @users = User.order(username: :asc)
    authorize @users
  end

  def altera_permission_login
     @user = User.find(params[:id])
  end

  def atualiza_permission_login
    if params[:id].present?
      user = User.find(params[:id])   
      user.update(role: params[:perfil].to_i)
      redirect_to tipo_permission_login_sims_people_path, notice: t('flash.notice.updated.')    
    else
      redirect_to  tipo_permission_login_sims_people_path, alert: t('flash.notice.notupdate.')    
    end
  end

  # GET /sims/sims_people/1
  # GET /sims/sims_people/1.json
  def show
  end

  # GET /sims/sims_people/new
  def new
    @sims_person = SimsPerson.new
    authorize @sims_person
  end

  def update_ativa_cracha    
    badge = SimsBadge.find(params[:id])   
    badge.update(crachadevolvido: "0")
    redirect_to sims_person_path(badge.crachapessoa), notice: t('flash.notice.updated.')        
  end

  def update_desativa_cracha
    badge = SimsBadge.find(params[:id])    
    badge.update(crachadevolvido: '1' )
    redirect_to sims_person_path(badge.crachapessoa), notice: t('flash.notice.updated.')  
  end

  # GET /sims/sims_people/1/edit
  def edit
    authorize @sims_person
  end

  def sims_dependent_all
  end

  # POST /sims/sims_people
  # POST /sims/sims_people.json
  def create
    @sims_person = SimsPerson.new(sims_person_params)
    authorize @sims_person
    respond_to do |format|
      if @sims_person.save
        format.html { redirect_to @sims_person, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @sims_person }
      else
        format.html { render :new }
        format.json { render json: @sims_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sims/sims_people/1
  # PATCH/PUT /sims/sims_people/1.json
  def update
    authorize @sims_person
    respond_to do |format|
      if @sims_person.update(sims_person_params)
        format.html { redirect_to @sims_person, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @sims_person }
      else
        format.html { render :edit }
        format.json { render json: @sims_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sims/sims_people/1
  # DELETE /sims/sims_people/1.json
  def destroy
    authorize @sims_person
    @sims_person.destroy
    respond_to do |format|
      format.html { redirect_to sims_people_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sims_person
      @sims_person = SimsPerson.find(params[:id])
      @sims_dependents = SimsDependent.where(pesdeppesid: params[:id]).order(pesdepnome: :asc)
      @sims_vehicles = PostgresqlViewPerson.select("placa, marca, modelo, automovel, id, ano, cor, renavam, proprietario, selo").veiculos(params[:id])     
      if SimsBigaLicense.exists?(:cnh_pes_id => params[:id])  
        @sims_biga_license = SimsBigaLicense.find_by(cnh_pes_id: params[:id])
        @marc = 0 
      else
        @marc = 1
      end
    end

    def update_validade_cracha      
      if params[:sims_person][:pes_cracha_id].present?                                  
        badge = SimsBadge.find(params[:sims_person][:pes_cracha_id])                  
        sims_user = SimsUser.find_by(userpessoa: badge.crachapessoa)
        badge.update(crachavalidade: params[:sims_person][:pes_cracha_val] )        
        sims_user.update(uservalidade: params[:sims_person][:pes_cracha_val] )        
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sims_person_params      
      params.require(:sims_person).permit(:pesfoto, :pescodigo, :pesncompleto, :pesnguerra, :pesidentidade, :pescpf, :pespostograd, 
                                    :pessexo, :pesdn, :pestiposangue, :pesemail, :pesquadro, :pesespecialidade, :pessituacao,
                                    :pesom, :peslocaltrabalho, :pes_esqsec_id, :pesfalert, :pesend, :pesbairro, :pesnum, 
                                    :pescidade, :pesuf, :pescep, :pesfone1, :pesfone2, :pesfonetrab, :pesfonetrabramal,
                                    :pesbanco, :pesagencia, :pescontacorrente, :pesfilpai, :pesfilmae, :pesnaturalcidade, :pesnaturaluf, 
                                    :pes_cracha_id, :pes_cracha_val, :pesobs, :peslogin)
    end
end
