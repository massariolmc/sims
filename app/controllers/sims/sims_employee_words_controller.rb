class Sims::SimsEmployeeWordsController < ApplicationController
  before_action :set_sims_employee_word, only: [:show, :edit, :update, :destroy]
  before_action :set_tb_pessoas, only: [:show, :edit, :update, :destroy, :new, :create]

  # GET /sims_employee_words
  # GET /sims_employee_words.json
  def index
    @sims_employee_words = SimsEmployeeWord.all
  end

  # GET /sims_employee_words/1
  # GET /sims_employee_words/1.json
  def show
  end

  # GET /sims_employee_words/new
  def new
    @sims_employee_word = SimsEmployeeWord.new
  end

  # GET /sims_employee_words/1/edit
  def edit
  end

  # POST /sims_employee_words
  # POST /sims_employee_words.json
  def create
    @sims_employee_word = SimsEmployeeWord.new(sims_employee_word_params)

    respond_to do |format|
      if @sims_employee_word.save
        format.html { redirect_to @sims_employee_word, notice: t('flash.notice.created') }
        format.json { render :show, status: :created, location: @sims_employee_word }
      else
        format.html { render :new }
        format.json { render json: @sims_employee_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sims_employee_words/1
  # PATCH/PUT /sims_employee_words/1.json
  def update
    respond_to do |format|
      if @sims_employee_word.update(sims_employee_word_params)
        format.html { redirect_to @sims_employee_word, notice: t('flash.notice.updated.') }
        format.json { render :show, status: :ok, location: @sims_employee_word }
      else
        format.html { render :edit }
        format.json { render json: @sims_employee_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sims_employee_words/1
  # DELETE /sims_employee_words/1.json
  def destroy
    @sims_employee_word.destroy
    respond_to do |format|
      format.html { redirect_to sims_employee_words_url, notice: t('flash.notice.destroied.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sims_employee_word
      @sims_employee_word = SimsEmployeeWord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sims_employee_word_params
      params.require(:sims_employee_word).permit()
    end
end
