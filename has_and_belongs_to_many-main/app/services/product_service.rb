class ProductService

    def self.create_product(params)
        product = Product.new(
      title: params[:title],
      description: params[:description],
      image_url: params[:image_url],
      price: params[:price]
    )
        product
    end

    def self.update_product(product_id, params)
        product = Product.find(product_id)
        product.update!(
      title: params[:title],
      description: params[:description],
      image_url: params[:image_url],
      price: params[:price],
      updated_at: Time.now
    )
        product
    end
end