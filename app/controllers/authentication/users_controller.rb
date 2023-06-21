
class Authentication::UsersController < ApplicationController
    skip_before_action :protect_pages

    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      #Aqui devuelve la ciudad de donde se registra el usuario y se agrega al usuario
      @user.country = FetchCountryService.new(request.remote_ip).perform
      #@user.country = FetchCountryService.new('24.48.0.1').perform
      
      
      if @user.save
        #Envio de mail sincrono, no sigue si no se envia el mail, por ello se usa later que es asinrono
        #UserMailer.welcome.deliver_now
        UserMailer.with(user: @user).welcome.deliver_later
        
        session[:user_id] = @user.id
        redirect_to products_path, notice: t('.created')
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :username, :password)
    end
end   