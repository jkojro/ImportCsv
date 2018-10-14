class ImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(row_hash, headers)
    product = Spree::Product.new
    headers.each do |header|
      set_attribute(product, header, row_hash["#{header}"])
    end
    product.save if product_valid?(product)
  end

  private

  def product_valid?(product)
    product.price.present? && product.valid?
  end

  def set_attribute(obj,header, value)
    obj.send("#{header}=", value) if obj.respond_to? :"#{header}"
  end
end