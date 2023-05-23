class ProductsController <ApplicationController
    def index
        @products = Product.all.with_attached_photo
    end 

    def show
        #@product = Product.find(params[:id])
        product
    end 

    def new
        @product = Product.new
    end

    def edit 
        #@product =  Product.find(params[:id])
        product
    end 

    def update 
        #@product =  Product.find(params[:id])

        if product.update(product_params)
            redirect_to products_path, notice: I18n.t('.updated')
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        #@product =  Product.find(params[:id]) //Se utiliza de ahora en mas el find definido mas abajo 
        #@product.destroy
        product.destroy
        redirect_to products_path, notice: I18n.t('.destroyed') , status: :see_other
    end 
    
    def create 
        @product = Product.new(product_params)

        #pp @product
        if @product.save
            redirect_to products_path, notice: I18n.t('.created')
        else 
            render :new, status: :unprocessable_entity
        end
    end 

    private 

    def product_params
        params.require(:product).permit(:title,:description,:price,:photo)
    end

    def product 
        @product =  Product.find(params[:id])
    end

end 