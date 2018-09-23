Spree::ProductsController.class_eval do

  def import
    product = Spree::Product.new
      product.name = 'Product placeholder'
      product.shipping_category_id = 1
      product.price = 2.00
      product.save
      redirect_to admin_products_path
    end
end