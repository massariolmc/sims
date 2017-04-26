class Sims::SimsResearchesController < ApplicationController
  before_action :set_postgresql_view_person, only: [:show, :edit, :update, :destroy]
  before_action :set_tb_pessoas

  # GET /postgresql_view_people
  # GET /postgresql_view_people.json
  def index    
      if params[:datai].present? && params[:dataf].present?
        verifica_dados(params[:pessoa], params[:esq], params[:mov], params[:sel], params[:busca], 
                      params[:datai], params[:dataf], params[:horai], params[:horaf], params[:cracha])
      else
          @postgresql_view_people = Hash.new
          flash[:alert] = 'Os campos data inicial e data final não podem ficar em brancos.'        
      end   
  end

  # GET /postgresql_view_people/1
  # GET /postgresql_view_people/1.json
  def show
  end

  # GET /postgresql_view_people/new
  def new
    @postgresql_view_person = PostgresqlViewPerson.new
  end

  # GET /postgresql_view_people/1/edit
  def edit
  end

  # POST /postgresql_view_people
  # POST /postgresql_view_people.json
  def create
    @postgresql_view_person = PostgresqlViewPerson.new(postgresql_view_person_params)

    respond_to do |format|
      if @postgresql_view_person.save
        format.html { redirect_to @postgresql_view_person, notice: 'Postgresql view person was successfully created.' }
        format.json { render :show, status: :created, location: @postgresql_view_person }
      else
        format.html { render :new }
        format.json { render json: @postgresql_view_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postgresql_view_people/1
  # PATCH/PUT /postgresql_view_people/1.json
  def update
    respond_to do |format|
      if @postgresql_view_person.update(postgresql_view_person_params)
        format.html { redirect_to @postgresql_view_person, notice: 'Postgresql view person was successfully updated.' }
        format.json { render :show, status: :ok, location: @postgresql_view_person }
      else
        format.html { render :edit }
        format.json { render json: @postgresql_view_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postgresql_view_people/1
  # DELETE /postgresql_view_people/1.json
  def destroy
    @postgresql_view_person.destroy
    respond_to do |format|
      format.html { redirect_to postgresql_view_people_url, notice: 'Postgresql view person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postgresql_view_person
      @postgresql_view_person = PostgresqlViewPerson.find(params[:id])
    end

    def verifica_dados(pessoa,esq,mov,sel,busca,datai,dataf,horai,horaf,cracha)

      case 
        when pessoa == '1'
          pp = "and mov_t_pessoa = #{pessoa}"
        when pessoa == '2'
          pp = "and mov_t_pessoa = #{pessoa}" 
        when pessoa == '3'
          pp = "and mov_t_pessoa = #{pessoa}" 
        when pessoa == '5'
          pp = "and mov_t_pessoa = #{pessoa}"     
        else
          pp = ""     
      end

      if esq.present?
        pp = " and  mov_t_pessoa = #{pessoa} and peslocaltrabalho = #{esq}"
      end

      case mov
        when '1'
          mm = " and mov_t_mov=#{mov}"
        when '2'
          mm = " and mov_t_mov=#{mov}"
        else
          mm = ""
      end

      case cracha
        when '1'
          cc = " and mov_c_cracha = #{cracha}"
        when '0'
          cc = " and mov_c_cracha = #{cracha}"
        else
          cc = ""
      end

      case 
        when sel == '1' && busca.present?
          ss = " and ncompleto ilike '%#{busca}%'"
        when sel ==  '2' && busca.present?
          ss = " and mov_cracha = #{busca}"
        when sel == '3' && busca.present?
          ss = " and mov_placa = '#{busca}'"
        else
          ss = ""
      end
      if !horai.present?
        horai = "00:00"
      end

      if !horaf.present?
        horaf = "23:59"
      end

      query = "(mov_dta_cad BETWEEN '#{datai} #{horai}:00.000000' AND '#{dataf} #{horaf}:00.000000')
      #{pp} #{mm} #{cc} #{ss}"
      puts "query: #{query}"
  
      @postgresql_view_people = SimsBigaMoviment.order("mov_dta_cad DESC").pesquisa(query).page(params[:page]).per(100)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postgresql_view_person_params
      params.fetch(:postgresql_view_person, {})
    end
end
