module Authentication
    extend ActiveSupport::Concern
  
    included do
        before_action :set_current_user
        before_action :protect_pages
        private 
        #Current es un metodo oculto que se puede visualizar en todo rails
        def set_current_user
            Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
        end
        #metodo que redirecciona al login si no esta logeado // unless = sino
        def protect_pages
            redirect_to new_session_path, alert: t('common.not_logged_in') unless Current.user
        end
    
    end 
end 