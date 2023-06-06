class CategoriesController < ApplicationController

  #Callback que aplica el metodo en todos los metodos de una vez 
  before_action :authorize!

  def index
    @categories = Category.all.order(name: :asc)
  end

  def new
    @category = Category.new
  end

  def edit
    category
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_url, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end

    #Permite escoger con que tipo devolver los datos
    #respond_to do |format|
      #if @category.save
      #  format.html { redirect_to categories_url, notice: t('.created') }
        #format.pdf->ejemplo
      #else
      #  format.html { render :new, status: :unprocessable_entity }
      #end
    #end
  end

  def update

    if category.update(category_params)
      redirect_to categories_url, notice: t('.updated')
  else
      render :edit, status: :unprocessable_entity
  end
  end

  def destroy
    category.destroy

        redirect_to categories_path, notice: t('.destroyed') , status: :see_other
  end

  private
    def category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
