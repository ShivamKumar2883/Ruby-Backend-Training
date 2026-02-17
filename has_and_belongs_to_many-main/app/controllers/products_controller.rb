class ProductsController < ApplicationController

    def index
        begin
        products = Product.all()
        render json: products.map(&:title)

        rescue ActiveRecord::RecordNotFound
        render json: { error: "No Products Found" }
        end
    end

    def show 
        begin
        product = Product.find(params[:id])
        render json: product

        rescue ActiveRecord::RecordNotFound
        render json: { error: "Product with ID #{params[:id]} not found." }
        end
    end
    
    def create
        begin
            product = ProductService.create_product(product_params)            
            product.valid?
            product.save!
            render json: product, status: :created
        
        rescue ActiveRecord::RecordInvalid
            render json: { error: product.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        begin 
            product = ProductService.update_product(params[:id], product_params)
            product.valid?
            product.save!
            render json: product, status: :updated

        rescue ActiveRecord::RecordNotFound
            render json: { error: "Product with ID #{params[:id]} not found." }
        rescue ActiveRecord::RecordInvalid => e
            render json: { 
                error: "Validation failed",
                details: e.record.errors.full_messages
            }   
        end
    end

    def destroy
        begin
            product = Product.find(params[:id])
            product.destroy!
            render json: { message: "Product deleted successfully" }    

        rescue ActiveRecord::RecordNotFound
            render json: { error: "Product with ID #{params[:id]} not found." }
        rescue ActiveRecord::RecordNotDestroyed => e
            render json: { 
                error: "Failed to delete the product",
                details: e.record.errors.full_messages
            }   
        end
    end

    def add_to_store
        product = Product.find(params[:id])
        store = Store.find(params[:store_id])
    
        product.stores << store
        render json: { 
            message: "Product added to store", 
            product: product.as_json(include: :stores),
            store: store.as_json(include: :products)
    }
    end

    def remove_from_store
        product = Product.find(params[:id])
        store = Store.find(params[:store_id])
    
        product.stores.delete(store)
        render json: { 
            message: "Product removed from store", 
            product: product.as_json(include: :stores)
    }
  end

    def stores
    product = Product.find(params[:id])
    render json: product.stores
    end

    private 
    def product_params
        params.permit(:title, :description, :image_url, :price)
    end

end
