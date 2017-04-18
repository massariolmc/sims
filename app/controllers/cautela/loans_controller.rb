class Cautela::LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]
  before_action :set_tb_pessoas, only: [:new, :edit, :update, :create]
  before_action :set_appointment, only: [:new, :show, :create, :update, :destroy, :edit]

  # GET /loans
  # GET /loans.json
  def index
    @loans = Loan.all
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)

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
      @products = Product.where("interest_id = #{params[:id]}")
    end

    def set_appointment
      @appointments = Appointment.all
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:person_id, :obs, :data_saida, :data_devolucao, :user_id, :status,
                                    :products_attributes => [:id, :nome, :descricao, :appointment_id, :qtde, :situation_id, :user_id, :obs, :_destroy])
    end
end
