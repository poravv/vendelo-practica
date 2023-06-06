module Authorization
    extend ActiveSupport::Concern

    included do 
    #Se importa el tipo de excepcion para poder manejarla 
    class NotAuthorizedError < StandardError; end

    #Aqui se maneja la excepcion
    rescue_from NotAuthorizedError do 
      redirect_to products_path, alert: t('common.not_authorized')
    end
    private 
    #Aqui se define es propietario y posteriormente se lanza la excepcion 
    def authorize! record = nil
        #Toma el nombre de la clase, lo convierte a singular y luego lo pone en CamelCase y lo convierte a una constante y se invoca al metodo que corresponde la accion 
        is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)
        #is_allowed = CategoryPolicy.new.edit
        raise NotAuthorizedError unless is_allowed
      end
    end 
end 