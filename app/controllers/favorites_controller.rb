class FavoritesController <ApplicationController

    def create
        #Favorite.create(product: product, user: Current.user)
        product.favorite!
        redirect_to product_path(product)
    end 

    def destroy
        product.unfavorite!
        redirect_to product_path(product), status: :see_other
    end

    private 

    #Memorization, el nombre de la variable de instancia debe coincidir con el nombre del metodo
    #cachear
    def product
        @product ||= Product.find(params[:product_id])
    end

end