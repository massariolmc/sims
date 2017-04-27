class Cautela::LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :anexar_comprovante, :update_anexar_comprovante, :obs_inativar, :update_obs_inativar]
  before_action :set_tb_pessoas, only: [:new, :edit, :update, :create]
  before_action :set_appointment, only: [:new, :show, :create, :update, :destroy, :edit, :pesquisa_cautelas]
  before_action :set_impressao, only: [:impressao]

  # GET /loans
  # GET /loans.json
  def index
    if current_user.admin?
      @loans = Loan.all.order(data_saida: :desc)
      @loans_fin = @loans.where("status2 = 3").order(data_devolucao: :desc)
      @loans_pend = @loans.where("status2 = 0 or status2 = 1").order(data_saida: :desc)
      @loans_inat = @loans.where("status2 = 2").order(data_devolucao: :desc)
    else
      if Appointment.exists?(person_id: current_user.person_id(current_user.username))
        @loans = Loan.lista_cautela_secao1(current_user.person_id(current_user.username),"").order(data_saida: :desc)
        @loans_fin = Loan.lista_cautela_secao1(current_user.person_id(current_user.username)," and loans.status2 = 3").order(data_devolucao: :desc)
        @loans_pend = Loan.lista_cautela_secao1(current_user.person_id(current_user.username),"and loans.status2 = 0 or loans.status2 = 1").order(data_saida: :desc)
        @loans_inat = Loan.lista_cautela_secao1(current_user.person_id(current_user.username), "and loans.status2 = 2").order(data_devolucao: :desc)

      elsif AssistentAppointment.exists?(person_id: current_user.person_id(current_user.username))
        @loans = Loan.lista_cautela_secao2(current_user.person_id(current_user.username),"").order(data_saida: :desc)
        @loans_fin = Loan.lista_cautela_secao2(current_user.person_id(current_user.username)," and loans.status2 = 3").order(data_devolucao: :desc)
        @loans_pend = Loan.lista_cautela_secao2(current_user.person_id(current_user.username),"and loans.status2 = 0 or loans.status2 = 1").order(data_saida: :desc)
        @loans_inat = Loan.lista_cautela_secao2(current_user.person_id(current_user.username), "and loans.status2 = 2").order(data_devolucao: :desc)
      else
        respond_to do |format|
          format.html {redirect_to appointments_path, alert: t('flash.alert.negado.')}
        end
      end
     
    end
    if @loans
      authorize @loans
    end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    authorize @loan
  end

  def finaliza_cautela
    if params[:id].present? && params[:valor].present?
      aux = Loan.find(params[:id])
      respond_to do |format|
        if aux.avatar_file_name.present? #Se tiver anexo, pode finalizar          
            if params[:valor] == '1'
              if aux.update(status2: 1)
                format.html {redirect_to aux, notice: t('flash.notice.updated.')}
              else
                render :edit
              end
            elsif params[:valor] == '2'
              if aux.update(status2: 2, data_devolucao: DateTime.now)
                format.html {redirect_to aux, notice: t('flash.notice.updated.')}
              else
                render :edit
              end            
            elsif params[:valor] == '3'
              if aux.update(status2: 3, data_devolucao: DateTime.now)
                format.html {redirect_to aux, notice: t('flash.notice.updated.')}
              else
                render :edit
              end
            end          
        else      
          format.html {redirect_to aux, alert: t('flash.alert.falta_anexo.')}
        end  
      end  
    end
  end

  # GET /loans/new
  def new
    @loan = Loan.new
    authorize @loan
  end

  # GET /loans/1/edit
  def edit
    authorize @loan
  end

  def abrir_anexo 
    aux = Loan.find(params[:id])  
    send_file aux.avatar.path, 
          filename: aux.avatar_file_name, 
          type: aux.avatar_content_type, 
          disposition: 'attachment' # or 'attachment' 
  end

  def impressao 
    respond_to do |format| 
      #format.html        
      format.pdf do 
        pdf = LoansPdf.new(@loan,@loan_product,current_user.login(current_user.username)) 
        send_data pdf.render, 
          filename: "Impressao do Atendimento", 
          type: 'application/pdf', 
          disposition: 'inline'      
      end 
    end 
  end

  def anexar_comprovante
  end

  def update_anexar_comprovante
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :anexar_comprovante }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def obs_inativar
  end

  def update_obs_inativar
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :obs_inativar }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def pesquisa_cautelas
     pesquisa( params[:mat], params[:nome], params[:data], params[:data_texto], params[:setor], params[:estado])
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)
    authorize @loan
    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    authorize @loan
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    authorize @loan
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
      @loan_product = Product.where("loan_id = #{params[:id]}")      
    end

    def set_impressao
      @loan = Loan.find(params[:id])
      @loan_product = Product.where("loan_id = #{params[:id]}")      
    end

    def set_appointment
      if current_user.admin?
        @appointments = Appointment.all
      else
        @appointments = Appointment.verifica_carga_pessoa(current_user.person_id(current_user.username))
      end
      
      @appointments = @appointments.sort_by { |a| [ ordena(a.person_id), a.sims_tba_esq_secao_id ] }
      #@appointments = Appointment.joins(:sims_person, :sims_department)
      #@appointments = appointments.person
    end  

  def ordena(var)
    if var.present?
     aux = SimsPerson.find(var)
     aux.pespostograd
    else
      "Não cadastrado"
    end
  end

  def pesquisa(mat,nome, data, data_texto, setor, estado)
    @@n2 = ""
    case 
      when mat == '1' && nome.present?
        n1 = SimsPerson.select("pesid").where(" pesncompleto ilike '%#{nome}%' ").limit(1)

        n1.each do |n|
          @@n2 = "loans.person_id = #{n.pesid}"   

        end        
      when mat == '2' && nome.present?        
        @@n2 = "nome ilike '%#{nome}%' " 
      when mat == '3' && nome.present?         
        @@n2 = "descricao ilike '%#{nome}%' "              
      else        
        @@n2 = ""     
    end 

    case 
        when data == '1' && data_texto.present?
          pp = "date(data_saida) = '#{data_texto}' "
        when data == '2' && data_texto.present?
          pp = "date(data_devolucao) = '#{data_texto}' "        
        else
          pp = ""     
    end

    if setor.present?
      ss = Appointment.find(setor.to_i)
      ss = "appointments.sims_tba_esq_secao_id = #{ss.sims_tba_esq_secao_id}"
    else
      ss = ""      
    end

    case 
        when estado == '0'
          ee = "status2 = 0 "
        when estado == '1'
          ee = "status2 = 1 "
        when estado == '2'
          ee = "status2 = 2 "
        when estado == '3'
          ee = "status2 = 3 "
        else
          ee = ""     
    end

        if pp.present? && @@n2.present?
         pp = "and #{pp}"
        end
        if (@@n2.present? || pp.present?) && ss.present?
          ss = "and #{ss}"
        end
        if (@@n2.present? || pp.present? || ss.present?) && ee.present?
          ee = "and #{ee} " 
        end
        
      query = "#{@@n2} #{pp} #{ss} #{ee}"
      puts " query: #{query} "
      if query.present?
        @loans_pesquisa = Loan.order("data_saida desc").pesquisa(query).page(params[:page]).per(100)
      else
        @loans_pesquisa = Hash.new
      end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:person_id, :obs, :data_saida, :data_devolucao, :user_id, :appointment_id, :status2, :avatar,
                                    :products_attributes => [:id, :nome, :descricao, :qtde, :situation_id, :user_id, :obs, :_destroy])
    end
end
