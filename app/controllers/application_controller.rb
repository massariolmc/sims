class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  
  include Pundit
  
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :person_exists?, if: :devise_controller?, only: [:create, :update]

   def person_exists?    
    aux = SimsPerson.select(:peslogin).verifica_people(params[:user][:username])
    if aux.blank?
      flash[:alert] = "Seu login não existe na base de dados ou esta inativado no Sims. Procure o administrador de rede." 
    end
  end

  def set_tb_pessoas
    @person = SimsPerson.all  
    @person_ef = SimsPerson.where("pessituacao = 4").order(pespostograd: :asc, pesnguerra: :asc)  
    @person_of = SimsPerson.where("pespostograd < 12").order(pespostograd: :asc, pesnguerra: :asc)    
    @organizations = SimsOrganization.all
    @squads = SimsSquad.order(lpsid: :asc)
    @patents = SimsPatent.all
    @bloods = SimsBlood.all
    @frames = SimsFrame.all
    @specialties = SimsSpecialty.all
    @situations = SimsSituation.all
    @departments = SimsDepartment.all
    @banks = SimsBank.all
    @families = SimsFamily.all  
    @employees = SimsEmployee.all
    @employee_words = SimsEmployeeWord.all    
    @simsusers = SimsUser.all
    @badges = SimsBadge.all
    @licenses = SimsBigaLicense.all    
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

 private

 def user_not_authorized(exception)
   flash[:alert] = 'Você não tem permissão para fazer esta ação Pundit.' 
   redirect_to(request.referrer || root_path) 
 end
end
