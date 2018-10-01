Spree::ProductsController.class_eval do

  def import
    Spree::Product.import(params[:file])
    redirect_to admin_products_path
  end
end
