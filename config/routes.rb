Rails.application.routes.draw do
  devise_for :users
  
  get 'hello/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	scope module: 'empenho' do
	  resources :especifications
	  resources :modalities

	  resources :interests do
	  	member do       
      		get :abrir_anexo
    	end  
	  end

	  resources :companies
	  resources :types
	end

	scope module: 'materialcarga' do
	  resources :equipment
	  resources :appointments
	  resources :assistent_appointments	  
	end

	scope module: 'cautela' do
	  resources :loans
	  resources :products
	end

	scope module: 'sims' do
		resources :sims_people do
			member do
				get :update_ativa_cracha
				get :update_desativa_cracha
				get :altera_permission_login
				put :atualiza_permission_login				
			end
			collection do
				get :index_desligados
				get :tipo_permission_login
			end
		end
		resources :sims_dependents do
			member do
				get :update_ativa_cracha
				get :update_desativa_cracha				
			end
		end
		resources :sims_employees do
			member do
				get :update_ativa_cracha
				get :update_desativa_cracha
				get :update_validade_cracha
			end
			collection do
				get :index_inativos_pensionistas
			end
		end
		resources :sims_employee_words
		resources :sims_cav_visitors
		resources :sims_biga_licenses do
			collection do
				get :busca_pessoa
				get :busca_pessoa_cad_cnh
				get :cnh_vencidas
			end
		end
		resources :sims_biga_vehicle_people
		resources :sims_researches
	end


	  root 'hello#index'
end
