class UsersController <ApplicationController
    #Para saltar la validacion
    skip_before_action :protect_pages, only: :show

    def show
        #Si no existe el usuario se debe lanzar una excepcion, en este caso se agrega una exclamacion 
        @user = User.find_by!(username: params[:username])
        #Logica para obtener todos los productos de un usuario, se filtra por user.id
        #Se reemplaza por nada ya que se utiliza turbo_fame_tag 
        #@pagy, @products = pagy_countless(FindProducts.new.call({ user_id: @user.id }).load_async, items: 12)
    end

end