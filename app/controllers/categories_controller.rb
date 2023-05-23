class CategoriesController < ApplicationController

  def index
    @categories = Category.all
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
      redirect_to categories_url, notice: I18n.t('.created')
    else 
      render :new, status: :unprocessable_entity
    end 
      
    #Permite escoger con que tipo devolver los datos
    #respond_to do |format|
      #if @category.save
      #  format.html { redirect_to categories_url, notice: I18n.t('.created') }
        #format.pdf->ejemplo
      #else
      #  format.html { render :new, status: :unprocessable_entity }
      #end
    #end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        redirect_to categories_url, notice: I18n.t('.updated') 
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      redirect_to categories_url, notice: I18n.t('.destroyed') 
    end
  end

  private
    def category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
