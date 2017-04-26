class PostgresqlViewPerson < ApplicationRecord
  
	  if Rails.env == 'development'
     self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 
  	self.table_name = "public.v_pessoas2"

    scope :veiculos, -> (query) {where(" id = #{query} and placa is not null")} 

    #essa função acha o ID da pessoa e outro campo que desejar
  	def procura_pessoa2(var,campo)
      if PostgresqlViewPerson.exists?(:id => var) 
        aux = PostgresqlViewPerson.find_by_id(var)
        p aux
      end
    end

    def procura_pessoa(var)
  		if PostgresqlViewPerson.exists?(:id => var) 
  			aux = PostgresqlViewPerson.find_by_id(var)  			
  			if aux.crachadevolvido == '0'
  				sit = "ATIVO"
  			else vaux.crachadevolvido == '1'
  				sit = "INATIVO"
  			end

  			if aux.crachavalidade 
  				p "#{aux.ncompleto} - Tipo do crachá: #{aux.tipo} - Posto/Graduação: #{aux.resp_posto} - Nome de Guerra: #{aux.resp_nguerra}
  			 - Nº do Cracha: #{aux.pes_cracha_id} - Validade do crachá: #{aux.crachavalidade.strftime("%d/%m/%Y")} - Situação do crachá: #{sit}"
  			else
  				p "#{aux.ncompleto} - Tipo do crachá: #{aux.tipo} - Posto/Graduação: #{aux.resp_posto} - Nome de Guerra: #{aux.resp_nguerra}
  			 - Nº do Cracha: #{aux.pes_cracha_id} - Validade do crachá: #{aux.crachavalidade}" 	
  			end
  		else
  			p "Esta pessoa foi deletada."
  		end
  	end

  	def busca_pessoa 
    if params[:busca_people].present?
      @sims = PostgresqlViewPerson.select("distinct(id),ncompleto,tipo,cnh,cat,uf").order("ncompleto asc").where(" ncompleto ilike '%#{params[:busca_people]}%'").page(params[:page]).per(20)    
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
end
