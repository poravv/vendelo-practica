require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
    test 'render a list of products' do
        get products_path # '/products'

        assert_response :success
        assert_select '.product', 2
    end 

    test 'render a detailed product page' do 
        get product_path(products(:ps4))

        assert_response :success
        assert_select '.title','PS4'
        assert_select '.description','Ps4 en buen estado'
        assert_select '.price','150'
    end

    test 'render a new product form' do 
        get new_product_path

        assert_response :success
        assert_select 'form'
    end

    test 'allow to create a new product' do 
        post products_path, params: {
            product: {
                title: 'Nintendo 64',
                description: 'Sin cables',
                price: 20000
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], I18n.t('.created')
    end

    test 'does not allow to create a new product with empty fields' do 
        post products_path, params: {
            product: {
                title: '',
                description: 'Sin cables',
                price: 200000
            }
        }
        assert_response :unprocessable_entity 
    end

    test 'render an edit product form' do 
        
        get edit_product_path(products(:ps4))

        assert_response :success
        assert_select 'form'
    end

    test 'allow to update a new product' do 
        patch product_path(products(:ps4)), params: {
            product: {
                price: 210000
            }
        }
        assert_redirected_to products_path
        assert_equal flash[:notice], I18n.t('.updated')
    end

    test 'does not allow to update a new product' do 
        patch product_path(products(:ps4)), params: {
            product: {
                price: nil
            }
        }
        assert_response :unprocessable_entity 
    end

    test 'can delete products' do
        assert_difference('Product.count',-1) do 
            delete product_path(products(:ps4))
        end

        assert_redirected_to products_path
        assert_equal flash[:notice], I18n.t('.destroyed')
    end
end