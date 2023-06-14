#Captura las excepciones que no sean de authentication y authorization
module Error
    extend ActiveSupport::Concern
  
    included do
      rescue_from ActiveRecord::RecordNotFound do
        redirect_to products_path, alert: t('.common.not_found')
      end
    end
end