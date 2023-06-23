class Product < ApplicationRecord
    include PgSearch::Model #Buscador
    include Favoritable

    #se incluye el metodo del buscador
    #para probar en rails.console->Product.search_full_text('PS4')
    pg_search_scope :search_full_text, against: {
        title: 'A',
        description: 'B'
    }

    ORDER_BY={
        newest: "created_at DESC",
        expensive: "price DESC",
        cheapest: "price ASC"
    }

    has_one_attached :photo
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    has_many :favorites, dependent: :destroy
    belongs_to :category
    belongs_to :user, default: -> { Current.user }

    def owner? 
    user_id==Current.user&.id
    end 

    #Metodo que reemplaza el html del cliente por el nuevo partial
    def broadcast
        broadcast_replace_to self, partial: 'products/product_details', locals: { product: self }
    end
end
