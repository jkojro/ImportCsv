module Spree
  module ImportCsv
    def import
      Spree::ImportProductsService.new(params[:file]).call if params[:file]
      redirect_to admin_products_path
    end
  end
end

Spree::ProductsController.prepend(Spree::ImportCsv)