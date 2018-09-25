require 'csv'

Spree::Product.class_eval  do
  def self.import(file)
    required_attributes = ['name', 'shipping_category_id', 'price']

    CSV.foreach(file.path, headers: true, col_sep: ';') do |row|
      headers = row.headers
      return unless headers_valid?(headers, required_attributes)
      row_hash = row.to_hash
      ImportWorker.perform_async(row_hash, headers)
    end
  end

  def self.headers_valid?(headers, required_attributes)
    (headers & required_attributes).count == 3
  end

  def product_valid?(product)
    product.price != nil ? product.valid? : false
  end

  def set_attribute(obj,header, value)
    obj.send("#{header}=", value) if obj.respond_to? :"#{header}"
  end
end
