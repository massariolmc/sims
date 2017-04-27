class Empenho::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :destroyable?, only: [:destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    authorize @company
  end

  # GET /companies/1/edit
  def edit
    authorize @company
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    authorize @company
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    authorize @company
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    authorize @company
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    def destroyable?
      if Interest.exists?(:company_id => params[:id])
        respond_to do |format|
          format.html { redirect_to companies_path, notice: t('flash.notice.dependent') }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:nome_fantasia, :razao_social, :cnpj, :telefone, :logradouro, :numero, :bairro, :cidade, :estado, :cep)
    end
end
