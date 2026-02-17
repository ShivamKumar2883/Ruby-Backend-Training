class StoresController < ApplicationController
  def index
    begin
    stores = Store.all()
    render json: stores.map(&:name)

    rescue ActiveRecord::RecordNotFound
    render json: { error: "No Stores Found" }
    end
  end

  def show
    begin
    store = Store.find(params[:id])
    render json: store

    rescue ActiveRecord::RecordNotFound
    render json: { error: "Store with ID #{params[:id]} not found." }
    end
  end

  def create
    begin
        store = Store.new(store_params)            
        store.valid?
        store.save!
        render json: store, status: :created
        
    rescue ActiveRecord::RecordInvalid
        render json: { error: store.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  def update
    begin
        store = Store.find(params[:id])
        store.update!(store_params)
        render json: store, status: :updated

    rescue ActiveRecord::RecordNotFound
        render json: { error: "Store with ID #{params[:id]} not found." }
    rescue ActiveRecord::RecordInvalid => e
        render json: { 
            error: "Validation failed",
            details: e.record.errors.full_messages
        }
      end
  end

  def delete
    begin
        store = Store.find(params[:id])
        store.destroy!
        render json: { message: "Store deleted successfully" }    

    rescue ActiveRecord::RecordNotFound
        render json: { error: "Store with ID #{params[:id]} not found." }
    rescue ActiveRecord::RecordNotDestroyed => e
        render json: { 
            error: "Failed to delete the store",
            details: e.record.errors.full_messages
        }   
    end
  end

  private
  def store_params
    params.require(:store).permit(:name, :information, :location, :state, :district)
  end

  def products
    store = Store.find(params[:id])
    render json: store.products
  end

  def add_product
    store = Store.find(params[:id])
    product = Product.find(params[:product_id])
  
    store.products << product
    render json: { 
      message: "Product added to store", 
      store: store.as_json(include: :products)
    }
  end

  def remove_product
    store = Store.find(params[:id])
    product = Product.find(params[:product_id])
  
    store.products.delete(product)
    render json: { 
       message: "Product removed from store", 
       store: store.as_json(include: :products)
    }
  end
end
