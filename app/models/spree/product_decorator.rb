require 'csv'

Spree::Product.class_eval  do
  def self.import(file)
    CSV.foreach(file.path, headers: true,  col_sep: ';') do |row|
    product_hash = row.to_hash
    product = Spree::Product.new
    product.name = product_hash['name']
    product.shipping_category_id = product_hash['shipping_category_id']
    product.price = product_hash['price']
    product.slug = product_hash['slug']
    product.description = product_hash['description']
    byebug
    product.save
    end
  end
end