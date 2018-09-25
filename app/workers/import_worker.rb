class ImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(row_hash, headers)
    product = Spree::Product.new
    headers.each do |header|
      product.set_attribute(product, header, row_hash["#{header}"])
    end
    product.save if product.product_valid?(product)
  end
end
