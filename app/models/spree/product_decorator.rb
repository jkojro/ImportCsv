require 'csv'

Spree::Product.class_eval  do
  def self.import(file)
    required_attributes = ['name', 'shipping_category_id', 'price']

    csv_file = CSV.read(file.path, headers: true, col_sep: ';')
    headers = csv_file.headers

    if headers_valid?(headers, required_attributes)
      csv_file.each do |row|
        product_hash = row.to_hash
        product = Spree::Product.new
        headers.each do |header|
          product.set_attribute(product, header, product_hash["#{header}"]) 
        end
        product.save if product_valid?(product)
      end
    end
  end

  def self.headers_valid?(headers, required_attributes)
    (headers & required_attributes).count == 3
  end

  def self.product_valid?(product)
    if product.price != nil
      product.valid?
    else
      false
    end
  end

  def set_attribute(obj,header, value)
    obj.send("#{header}=", value) if obj.respond_to? :"#{header}"
  end
end
