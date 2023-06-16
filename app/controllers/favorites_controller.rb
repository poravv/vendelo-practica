class FavoritesController <ApplicationController

    def index
    
    end

    def create
        #Favorite.create(product: product, user: Current.user)
        product.favorite!
        #para devolver varios tipos de formato no solo html directo, se implementa respond_to con el format html u otros formatos
        #Esto es para que funcione el redirect parcial de turbo
        respond_to do |format|
            format.html do 
                redirect_to product_path(product)    
            end
            format.turbo_stream do 
                #Va ir al html y va buscar por id para actualizar una zona especifica
                render turbo_stream: turbo_stream.replace("favorite",partial: "products/favorite",locals: { product:product })
            end
        end
    end 

    def destroy
        product.unfavorite!
        
        respond_to do |format|
            format.html do 
                redirect_to product_path(product), status: :see_other
            end
            format.turbo_stream do 
                render turbo_stream: turbo_stream.replace("favorite",partial: "products/favorite",locals: { product:product })
            end
        end
    end

    private 

    #Memorization, el nombre de la variable de instancia debe coincidir con el nombre del metodo
    #cachear
    def product
        @product ||= Product.find(params[:product_id])
    end

end