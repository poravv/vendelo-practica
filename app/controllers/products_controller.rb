class ProductsController <ApplicationController
    skip_before_action :protect_pages, only: [:index, :show]
    
    def index
        @categories = Category.order(name: :asc).load_async

        ##//Aqui el codigo manual que se limpia posteriormente para optimizacion 
        ##Imprime en consola un parametro
        ##pp params[:category_id]
        #@categories = Category.order(name: :asc).load_async
        #@products = Product.all.with_attached_photo

        #if params[:category_id]
        #    @products = @products.where(category_id: params[:category_id])
        #end

        #if params[:min_price].present?
        #    @products = @products.where("price >= ?",params[:min_price])
        #end

        #if params[:max_price].present?
        #    @products = @products.where("price <= ?",params[:max_price])
        #end

        #if params[:query_text].present?
        #    @products = @products.search_full_text(params[:query_text])
        #end
        ##Para manejar el combo y definir el valor por defecto
        #order = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
        #@products = @products.order(order).load_async
        ##Logica para devolver 12 productos
        #@pagy, @products = pagy_countless(@products,items:12)
        
        #se actualiza params index para definir lo que se puede mandar como parametro
        @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async,items:12)
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
        #Metodo creado e application_controller disponible globalmente que evita se acceda desde la url 
        authorize! product
    end 

    def update 
        #@product =  Product.find(params[:id])
        authorize! product
        if product.update(product_params)
            redirect_to products_path, notice: t('.updated')
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        #@product =  Product.find(params[:id]) //Se utiliza de ahora en mas el find definido mas abajo 
        #@product.destroy
        authorize! product
        product.destroy
        redirect_to products_path, notice: t('.destroyed') , status: :see_other
    end 
    
    def create 
        @product = Product.new(product_params)
        #pp @product
        if @product.save
            redirect_to products_path, notice: t('.created')
        else 
            render :new, status: :unprocessable_entity
        end
    end 

    private 

    def product_params
        params.require(:product).permit(:title,:description,:price,:photo,:category_id)
    end

    def product_params_index
        params.permit( :category_id, :min_price, :max_price, :query_text, :order_by, :page)
        
    end

    def product 
        @product =  Product.find(params[:id])
    end

end 